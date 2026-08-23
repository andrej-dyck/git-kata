#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
# source "$REPO_ROOT_DIR/<other-exercise>/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo "$exerciseDir" "$thisDir/README.md" || return

  # TODO setup git history for exercise
}

run-init-exercise "$@"
