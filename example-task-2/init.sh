#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/example-task-1/init.sh"

init-exercise() {
  local exerciseDir="$1"

  cd "$exerciseDir"
  touch ".gitignore"
  touch "task-2.md"
}

run-init-exercise "$@"
