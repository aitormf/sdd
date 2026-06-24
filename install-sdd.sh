#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf '%s\n' "Usage: bash install-sdd.sh <destination-dir>"
}

if [ "$#" -ne 1 ]; then
  usage
  exit 1
fi

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source_root="$script_dir"
destination="$1"

mkdir -p "$destination"

source_real="$(realpath "$source_root")"
dest_real="$(realpath "$destination")"

if [ "$source_real" = "$dest_real" ]; then
  printf '%s\n' "Destination must be different from the source repository."
  exit 1
fi

copy_item() {
  local item="$1"
  local source_path="$source_root/$item"

  if [ ! -e "$source_path" ]; then
    return 0
  fi

  mkdir -p "$destination/$(dirname "$item")"
  cp -R "$source_path" "$destination/$(dirname "$item")/"
}

for item in \
  AGENTS.md \
  CLAUDE.md \
  templates \
  docs/sdd \
  docs/cercanias-madrid \
  .opencode \
  .claude \
  .agents \
  .codex
do
  copy_item "$item"
done

printf '%s\n' "Installed SDD pack into: $destination"
