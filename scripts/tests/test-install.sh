#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDD_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
INSTALLER="$SDD_ROOT/scripts/install-sdd.sh"
TMPDIR="$(mktemp -d)"
PASS=0
FAIL=0

cleanup() { rm -rf "$TMPDIR"; }
trap cleanup EXIT

# ── test helpers ─────────────────────────────────────────────────────
pass() { PASS=$((PASS + 1)); echo "  ✓ $1"; }
fail() { FAIL=$((FAIL + 1)); echo "  ✗ $1"; }
assert_file() { [ -f "$1" ] && pass "$2" || fail "$2: $1 not found"; }
assert_link() { [ -L "$1" ] && pass "$2" || fail "$2: $1 is not a symlink"; }
assert_readable() { [ -f "$1" ] && [ -s "$1" ] && pass "$2" || fail "$2: $1 not readable or empty"; }
assert_no_dir() { [ ! -d "$1" ] && pass "$2" || fail "$2: $1 should not exist"; }
assert_contains() { grep -q "$2" "$1" && pass "$3" || fail "$3: '$2' not found in $1"; }

SKILLS=(idea-to-spec spec-to-plan plan-to-tasks review-spec)
AGENTS=(implement spec-planner spec-reviewer)

# ── Test 1: Install all CLIs ────────────────────────────────────────
echo "=== Test 1: Install all CLIs ==="
DEST="$TMPDIR/test-all"
"$INSTALLER" "$DEST"

echo "  -- .sdd/ contents --"
for s in "${SKILLS[@]}"; do
  assert_file "$DEST/.sdd/skills/$s/SKILL.md" ".sdd/skills/$s"
done
for a in "${AGENTS[@]}"; do
  assert_file "$DEST/.sdd/agents/$a.md" ".sdd/agents/$a"
done
assert_file "$DEST/.sdd/templates/spec-template.md" ".sdd/templates/spec-template"
assert_file "$DEST/.sdd/templates/plan-template.md" ".sdd/templates/plan-template"
assert_file "$DEST/.sdd/templates/tasks-template.md" ".sdd/templates/tasks-template"
assert_file "$DEST/.sdd/templates/review-template.md" ".sdd/templates/review-template"

echo "  -- claude (symlinks) --"
for s in "${SKILLS[@]}"; do
  assert_link "$DEST/.claude/skills/$s/SKILL.md" "claude skill link $s"
  assert_readable "$DEST/.claude/skills/$s/SKILL.md" "claude skill readable $s"
done
for a in "${AGENTS[@]}"; do
  assert_link "$DEST/.claude/agents/$a.md" "claude agent link $a"
  assert_readable "$DEST/.claude/agents/$a.md" "claude agent readable $a"
done

echo "  -- agents (symlinks) --"
for s in "${SKILLS[@]}"; do
  assert_link "$DEST/.agents/skills/$s/SKILL.md" "agents skill link $s"
done
for a in "${AGENTS[@]}"; do
  assert_link "$DEST/.agents/agents/$a.md" "agents agent link $a"
done

echo "  -- opencode (skills: symlinks, agents: generated) --"
for s in "${SKILLS[@]}"; do
  assert_link "$DEST/.opencode/skills/$s/SKILL.md" "opencode skill link $s"
done
for a in "${AGENTS[@]}"; do
  assert_file "$DEST/.opencode/agents/$a.md" "opencode agent $a"
  assert_contains "$DEST/.opencode/agents/$a.md" "permission:" "opencode agent $a has permission block"
done

echo "  -- codex (skills: symlinks, agents: TOML) --"
for s in "${SKILLS[@]}"; do
  assert_link "$DEST/.codex/skills/$s/SKILL.md" "codex skill link $s"
done
for a in "${AGENTS[@]}"; do
  assert_file "$DEST/.codex/agents/$a.toml" "codex agent $a"
  assert_contains "$DEST/.codex/agents/$a.toml" "developer_instructions" "codex agent $a has developer_instructions"
  assert_contains "$DEST/.codex/agents/$a.toml" "sandbox_mode" "codex agent $a has sandbox_mode"
done

# ── Test 2: Idempotence ─────────────────────────────────────────────
echo ""
echo "=== Test 2: Idempotence ==="
"$INSTALLER" "$DEST" > /dev/null
for s in "${SKILLS[@]}"; do
  assert_readable "$DEST/.claude/skills/$s/SKILL.md" "idempotent claude skill $s"
done
for a in "${AGENTS[@]}"; do
  assert_readable "$DEST/.claude/agents/$a.md" "idempotent claude agent $a"
  assert_file "$DEST/.codex/agents/$a.toml" "idempotent codex agent $a"
done
pass "re-run completed without error"

# ── Test 3: Single CLI ──────────────────────────────────────────────
echo ""
echo "=== Test 3: Single CLI (claude only) ==="
DEST2="$TMPDIR/test-single"
"$INSTALLER" "$DEST2" claude > /dev/null
assert_file "$DEST2/.sdd/agents/implement.md" "sdd installed"
assert_link "$DEST2/.claude/agents/implement.md" "claude agent present"
assert_no_dir "$DEST2/.opencode" "no opencode dir"
assert_no_dir "$DEST2/.codex" "no codex dir"
assert_no_dir "$DEST2/.agents" "no agents dir"

# ── Test 4: Multiple selected CLIs ──────────────────────────────────
echo ""
echo "=== Test 4: Two CLIs (opencode + codex) ==="
DEST3="$TMPDIR/test-two"
"$INSTALLER" "$DEST3" opencode codex > /dev/null
assert_no_dir "$DEST3/.claude" "no claude dir"
assert_no_dir "$DEST3/.agents" "no agents dir"
assert_file "$DEST3/.opencode/agents/implement.md" "opencode agent present"
assert_file "$DEST3/.codex/agents/implement.toml" "codex agent present"

# ── Test 5: OpenCode agent format ────────────────────────────────────
echo ""
echo "=== Test 5: OpenCode agent format ==="
OC_IMPL="$DEST/.opencode/agents/implement.md"
assert_contains "$OC_IMPL" "description:" "has description"
assert_contains "$OC_IMPL" "mode: subagent" "has mode"
assert_contains "$OC_IMPL" "edit: allow" "implement has edit: allow"
assert_contains "$OC_IMPL" "bash: allow" "implement has bash: allow"

OC_PLAN="$DEST/.opencode/agents/spec-planner.md"
assert_contains "$OC_PLAN" "edit: deny" "planner has edit: deny"
assert_contains "$OC_PLAN" "bash: ask" "planner has bash: ask"

# ── Test 6: Codex TOML format ────────────────────────────────────────
echo ""
echo "=== Test 6: Codex TOML format ==="
CX_IMPL="$DEST/.codex/agents/implement.toml"
assert_contains "$CX_IMPL" 'name = "implement"' "has name"
assert_contains "$CX_IMPL" 'sandbox_mode = "workspace-write"' "implement has workspace-write"
assert_contains "$CX_IMPL" 'model = "gpt-5.4"' "has default model"
assert_contains "$CX_IMPL" 'model_reasoning_effort = "high"' "has reasoning effort"

CX_PLAN="$DEST/.codex/agents/spec-planner.toml"
assert_contains "$CX_PLAN" 'sandbox_mode = "read-only"' "planner has read-only"

# ── Test 7: Codex model override ─────────────────────────────────────
echo ""
echo "=== Test 7: CODEX_MODEL override ==="
DEST4="$TMPDIR/test-model"
CODEX_MODEL="o3" "$INSTALLER" "$DEST4" codex > /dev/null
assert_contains "$DEST4/.codex/agents/implement.toml" 'model = "o3"' "model override works"

# ── Test 8: Error cases ──────────────────────────────────────────────
echo ""
echo "=== Test 8: Error handling ==="
if "$INSTALLER" 2>/dev/null; then
  fail "should fail with no args"
else
  pass "fails with no args"
fi

if "$INSTALLER" "$SDD_ROOT" 2>/dev/null; then
  fail "should fail when dest=source"
else
  pass "fails when dest equals source"
fi

if "$INSTALLER" "$TMPDIR/test-err" invalid_cli 2>/dev/null; then
  fail "should fail with unknown CLI"
else
  pass "fails with unknown CLI"
fi

# ── Test 9: Symlink targets resolve ──────────────────────────────────
echo ""
echo "=== Test 9: Symlink targets resolve correctly ==="
target="$(readlink "$DEST/.claude/agents/implement.md")"
[ "$target" = "../../.sdd/agents/implement.md" ] && pass "agent symlink target correct" || fail "agent symlink target: $target"

target="$(readlink "$DEST/.claude/skills/idea-to-spec/SKILL.md")"
[ "$target" = "../../../.sdd/skills/idea-to-spec/SKILL.md" ] && pass "skill symlink target correct" || fail "skill symlink target: $target"

# ── Summary ──────────────────────────────────────────────────────────
echo ""
echo "=== Results: $PASS passed, $FAIL failed ==="
[ "$FAIL" -eq 0 ] && exit 0 || exit 1