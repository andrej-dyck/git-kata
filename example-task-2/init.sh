#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/example-task-1/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo-with-origin "$exerciseDir" "$thisDir/README.md" || return

  echo-exec touch "task-1.md" || return
  git-commit "add task 1"
}

run-init-exercise "$@"
