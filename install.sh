#!/usr/bin/env bash
# Links planchunk into your home folder and into the tools you pick.
# Usage: ./install.sh [--claude] [--codex] [--force]
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
HOME_DIR="${HOME}"
FORCE=0
TARGETS=()

for arg in "$@"; do
  case "$arg" in
    --claude) TARGETS+=("$HOME_DIR/.claude/skills") ;;
    --codex) TARGETS+=("$HOME_DIR/.codex/skills") ;;
    --force) FORCE=1 ;;
    *) echo "Unknown option: $arg" >&2; exit 1 ;;
  esac
done

link() {
  local src="$1" dest="$2"
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    return
  fi
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    if [ "$FORCE" -eq 1 ]; then
      rm -rf "$dest"
    else
      echo "Skip (exists, use --force): $dest"
      return
    fi
  fi
  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  echo "Linked: $dest"
}

link "$REPO" "$HOME_DIR/.planchunk"

for target in "${TARGETS[@]:-}"; do
  [ -n "$target" ] || continue
  for skill in "$REPO"/skills/*/; do
    skill="${skill%/}"
    link "$skill" "$target/$(basename "$skill")"
  done
done

echo "Done. Skills read shared files from ~/.planchunk."
