#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/111-local-interactive-rebase-delete-commits/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo "$exerciseDir" "$thisDir/README.md" || return

  init-ac-automation-branch || return #from 106
  git-integrate-into-main "living-room-light-automation" || return
  git-switch-branch "living-room-ac-automation" || return
  wip-commits-ac-automation || return
}

wip-commits-ac-automation() {
  commit-empty-automation-rules || return # from 103

  define-device-traits || return # from 103
  commit-living-room-ac "install ac" || return # from 104

  commit-living-room-sensors-thermometer "install thermometer" || return # from 107
  commit-living-room-ac-rule-on "ac on temp" || return # from 107
  commit-living-room-ac-rule-off "ac off temp" || return # from 107
  commit-living-room-sensors-balcony-door "install balcony-door sensor" || return # from 107
  commit-living-room-ac-rule-on-off-balcony-door "ac on/off balcony-door" || return # from 107
}

run-init-exercise "$@"
