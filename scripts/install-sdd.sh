#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDD_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CODEX_MODEL="${CODEX_MODEL:-gpt-5.4}"
CODEX_REASONING="${CODEX_REASONING:-high}"
ALL_CLIS=(claude agents opencode codex)

usage() {
  cat <<EOF
Usage: install-sdd.sh <dest-dir> [cli ...]

Install SDD agents, skills, and templates into a project.

Arguments:
  dest-dir    Target project directory
  cli ...     CLIs to configure: claude, agents, opencode, codex
              If omitted, installs for all CLIs

Examples:
  install-sdd.sh /path/to/project
  install-sdd.sh /path/to/project claude codex
  install-sdd.sh /path/to/project opencode

Environment:
  CODEX_MODEL       Codex model (default: gpt-5.4)
  CODEX_REASONING   Codex reasoning effort (default: high)
EOF
}

if [ "$#" -lt 1 ]; then
  usage
  exit 1
fi

mkdir -p "$1"
DEST="$(cd "$1" && pwd)"
shift

CLIS=()
if [ "$#" -eq 0 ]; then
  CLIS=("${ALL_CLIS[@]}")
else
  for cli in "$@"; do
    case "$cli" in
      claude|agents|opencode|codex) CLIS+=("$cli") ;;
      *) echo "Unknown CLI: $cli (valid: claude, agents, opencode, codex)" >&2; exit 1 ;;
    esac
  done
fi

SDD_REAL="$(realpath "$SDD_ROOT")"
DEST_REAL="$(realpath "$DEST")"
if [ "$SDD_REAL" = "$DEST_REAL" ]; then
  echo "Destination must be different from the SDD source repository." >&2
  exit 1
fi

# ── helpers ──────────────────────────────────────────────────────────
parse_frontmatter() {
  awk '/^---$/ { count++; next } count == 1 { print }' "$1"
}

parse_body() {
  awk 'BEGIN{c=0} /^---$/{c++;next} c>=2{print}' "$1"
}

yaml_val() {
  local key="$1" val
  val="$(grep "^${key}:" || true)"
  [ -z "$val" ] && return 0
  echo "$val" | sed "s/^${key}: *//" | sed 's/^"\(.*\)"$/\1/'
}

# ── Step 1: Copy to .sdd/ ───────────────────────────────────────────
echo "==> Installing SDD into: $DEST/.sdd/"

rm -rf "$DEST/.sdd"
mkdir -p "$DEST/.sdd"
cp -R "$SDD_ROOT/agents" "$DEST/.sdd/"
cp -R "$SDD_ROOT/skills" "$DEST/.sdd/"
cp -R "$SDD_ROOT/templates" "$DEST/.sdd/"
echo "    .sdd/ copied ✓"

# ── Step 2: Create CLI integrations ─────────────────────────────────
create_skill_links() {
  local cli_dir="$1"
  for skill_dir in "$DEST/.sdd/skills"/*/; do
    local name target_dir
    name="$(basename "$skill_dir")"
    target_dir="$DEST/$cli_dir/skills/$name"
    mkdir -p "$target_dir"
    rm -f "$target_dir/SKILL.md"
    ln -s "../../../.sdd/skills/$name/SKILL.md" "$target_dir/SKILL.md"
  done
}

create_agent_links() {
  local cli_dir="$1"
  mkdir -p "$DEST/$cli_dir/agents"
  for agent_file in "$DEST/.sdd/agents"/*.md; do
    local name="$(basename "$agent_file")"
    rm -f "$DEST/$cli_dir/agents/$name"
    ln -s "../../.sdd/agents/$name" "$DEST/$cli_dir/agents/$name"
  done
}

# ── OpenCode agent generation ───────────────────────────────────────
permission_block() {
  local mode="$1"
  echo "  read: allow"
  if [ "$mode" = "acceptEdits" ]; then
    echo "  edit: allow"
  else
    echo "  edit: deny"
  fi
  echo "  glob: allow"
  echo "  grep: allow"
  echo "  list: allow"
  if [ "$mode" = "acceptEdits" ]; then
    echo "  bash: allow"
  else
    echo "  bash: ask"
  fi
  echo "  task: allow"
  echo "  skill: allow"
  echo "  question: allow"
  echo "  webfetch: ask"
  echo "  external_directory: deny"
}

generate_opencode_agents() {
  mkdir -p "$DEST/.opencode/agents"
  for src in "$DEST/.sdd/agents"/*.md; do
    local name fm body description mode perm_mode dst
    name="$(basename "$src")"
    dst="$DEST/.opencode/agents/$name"
    fm="$(parse_frontmatter "$src")"
    body="$(parse_body "$src")"
    description="$(echo "$fm" | yaml_val description)"
    perm_mode="$(echo "$fm" | yaml_val permissionMode)"
    mode="$(echo "$fm" | yaml_val mode)"
    [ -z "$perm_mode" ] && perm_mode="plan"
    {
      echo "---"
      echo "description: $description"
      [ -n "$mode" ] && echo "mode: $mode"
      echo "permission:"
      permission_block "$perm_mode"
      echo "---"
      echo "$body"
    } > "$dst"
  done
}

# ── Codex TOML agent generation ─────────────────────────────────────
sandbox_for_mode() {
  case "$1" in
    acceptEdits) echo "workspace-write" ;;
    *)           echo "read-only" ;;
  esac
}

generate_codex_agents() {
  mkdir -p "$DEST/.codex/agents"
  for src in "$DEST/.sdd/agents"/*.md; do
    local base fm body name description perm_mode sandbox model instructions dst
    base="$(basename "$src" .md)"
    dst="$DEST/.codex/agents/$base.toml"
    fm="$(parse_frontmatter "$src")"
    body="$(parse_body "$src")"
    name="$(echo "$fm" | yaml_val name)"
    description="$(echo "$fm" | yaml_val description)"
    perm_mode="$(echo "$fm" | yaml_val permissionMode)"
    [ -z "$perm_mode" ] && perm_mode="plan"
    sandbox="$(sandbox_for_mode "$perm_mode")"
    model="$(echo "$fm" | yaml_val codex_model)"
    [ -z "$model" ] && model="$CODEX_MODEL"
    instructions="$(echo "$body" | sed '1{ /^$/d; }' | sed 's/^## \(.*\)/\1:/' | sed '/^# /d' | sed '/^$/{ N; /^\n$/d; }')"
    {
      echo "name = \"$name\""
      echo "description = \"$description\""
      echo "developer_instructions = \"\"\""
      echo "$instructions"
      echo "\"\"\""
      echo "model = \"$model\""
      echo "model_reasoning_effort = \"$CODEX_REASONING\""
      echo "sandbox_mode = \"$sandbox\""
    } > "$dst"
  done
}

# ── Install each selected CLI ───────────────────────────────────────
for cli in "${CLIS[@]}"; do
  echo "--- CLI: $cli ---"
  case "$cli" in
    claude)
      create_skill_links ".claude"
      create_agent_links ".claude"
      echo "    .claude/ ✓ (symlinks)"
      ;;
    agents)
      create_skill_links ".agents"
      create_agent_links ".agents"
      echo "    .agents/ ✓ (symlinks)"
      ;;
    opencode)
      create_skill_links ".opencode"
      generate_opencode_agents
      echo "    .opencode/ ✓ (skills: symlinks, agents: generated)"
      ;;
    codex)
      create_skill_links ".codex"
      generate_codex_agents
      echo "    .codex/ ✓ (skills: symlinks, agents: generated TOML)"
      ;;
  esac
done

echo "==> Done. SDD installed in: $DEST"
