#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/105-local-rebase-with-conflicts/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo "$exerciseDir" "$thisDir/README.md" || return

  init-ac-automation-branch || return
  wip-commits-ac-automation || return
}

init-ac-automation-branch() {
  # main
  commit-empty-rooms || return # from 101
  commit-living-room || return # from 102
  commit-empty-devices || return # from 103
  commit-living-room-light  || return #from 103
  commit-living-room-presence-sensor || return # from 103
  commit-living-room-ambient-light-sensor || return # from 103

  # another feature "living-room-light-automation"
  feature-living-room-light-automation "living-room-light-automation" || return # from 104
  git-switch-main || return

  # feature "living-room-ac-automation"
  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  git-new-branch "living-room-ac-automation" || return
}

wip-commits-ac-automation() {
  commit-empty-automation-rules || return # from 104
  commit-living-room-ac || return # from 104
  commit-device-traits-schema || return
  commit-living-room-sensors-thermometer || return # from 104
  commit-living-room-ac-rules || return # from 105
  commit-living-room-sensors-balcony-door|| return # from 104
}

commit-device-traits-schema() {
  define-device-traits || return #from 103

  git-commit "${1:-define traits for devices}"
}

run-init-exercise "$@"
