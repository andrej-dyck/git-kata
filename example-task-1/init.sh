#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"

init-exercise() {
  local exerciseDir="$1"

  cd "$exerciseDir"
  touch ".gitignore"
  touch "task-1.md"
}

run-init-exercise "$@"
