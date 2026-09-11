#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/104-local-rebase-onto-main/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo-with-origin "$exerciseDir" "$thisDir/README.md" || return

  # main
  commit-initial-work-on-main || return
  git-push || return

  # feature "living-room-light-automation"
  feature-living-room-light-automation "living-room-light-automation" || return
  git-push-new-branch "living-room-light-automation" || return

  # additional work on main
  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  additional-work-on-main || return # from 104
  git-push || return

  # start task on branch "living-room-light-automation"
  git-switch-branch "living-room-light-automation" || return
}

commit-initial-work-on-main() {
  git-switch-main || return
  commit-empty-rooms || return # from 101
  commit-living-room || return # from 102
  commit-empty-devices || return # from 103
  commit-living-room-light || return # from 103
}

feature-living-room-light-automation() {
  git-new-branch "$1" || return

  commit-living-room-presence-sensor || return # from 103
  commit-living-room-ambient-light-sensor || return # from 103
  commit-living-room-light-traits || return # from 103
  commit-empty-automation-rules || return # from 103
  commit-living-room-light-rules || return
}

run-init-exercise "$@"
