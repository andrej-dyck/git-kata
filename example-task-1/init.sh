#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo "$exerciseDir" "$thisDir/README.md" || return $?
  cd "$exerciseDir" || return $?

  echo-exec touch "task-1.md"
  git-commit "add task 1"

  git shortlog
}

run-init-exercise "$@"
