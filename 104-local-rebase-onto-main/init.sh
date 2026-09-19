#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/103-local-undo-last-commits/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo "$exerciseDir" "$thisDir/README.md" || return

  # main
  commit-initial-work-on-main || return # from 103

  # feature "living-room-light-automation"
  feature-living-room-light-automation "living-room-light-automation" || return

  # additional work on main
  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  additional-work-on-main || return

  # start task on branch "living-room-light-automation"
  git-switch-branch "living-room-light-automation" || return
}

feature-living-room-light-automation() {
  git-new-branch "$1" || return

  commit-living-room-light-traits || return # from 103
  commit-living-room-light-sensors || return # from 103
  commit-empty-automation-rules || return # from 103
  commit-living-room-light-rules || return
}

commit-living-room-light-rules() {
  define-lights-on-presence-rule || return
  define-lights-off-presence-rule || return
  define-lights-on-off-ambient-light-rule || return

  git-commit "automate living-room light"
}

additional-work-on-main() { # TODO rework 203
  git-switch-main || return
  commit-device-traits-schema || return
  commit-empty-automation-rules || return # from 103
}

commit-device-traits-schema() {
  define-device-traits || return #from 103

  git-commit "${1:-define traits for devices}"
}

run-init-exercise "$@"
