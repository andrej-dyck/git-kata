#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/104-local-rebase-onto-main/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo-with-origin "$exerciseDir" "$thisDir/README.md" || return

  # main
  commit-initial-work-on-main || return # from 103
  git-push || return

  # feature "living-room-light-automation"
  feature-living-room-light-automation "living-room-light-automation" || return # from 104
  git-push-new-branch "living-room-light-automation" || return

  # additional work on main
  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  additional-work-on-main || return # from 104
  git-push || return

  # start task on branch "living-room-light-automation"
  git-switch-branch "living-room-light-automation" || return
}

run-init-exercise "$@"
