#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/103-local-undo-last-commits/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo-with-origin "$exerciseDir" "$thisDir/README.md" || return

  commit-initial-work-on-main || return # from 103
  git-push || return

  wip-feature-lights-automation "living-room-light-automation" || return # from 103
  git-push-new-branch "living-room-light-automation" || return
}

run-init-exercise "$@"
