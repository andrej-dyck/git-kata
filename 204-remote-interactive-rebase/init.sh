#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/112-local-interactive-rebase-onto-main/init.sh"
source "$REPO_ROOT_DIR/203-remote-rebase-onto-main/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo-with-origin "$exerciseDir" "$thisDir/README.md" || return

  # main
  commit-initial-work-on-main || return # from 203
  git-push

  # feature "living-room-ac-automation"
  git-switch-main || return
  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  start-commits-ac-automation "living-room-ac-automation" || return
  git-push-new-branch "living-room-ac-automation" || return

  # advance main
  git-switch-main || return
  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  commit-device-traits-schema || return # from 106
  commit-empty-automation-rules || return # from 103
  git-push || return

  # continue on "living-room-ac-automation"
  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  continue-wip-commits-ac-automation "living-room-ac-automation" || return
}

start-commits-ac-automation() {
  git-new-branch "$1" || return

  define-device-traits || return # from 103
  commit-living-room-ac "install ac" || return # from 104
  commit-living-room-sensors "install sensors" || return # from 110
}

continue-wip-commits-ac-automation() {
  git-switch-branch "$1" || return

  commit-empty-automation-rules || return # from 104

  commit-living-room-ac-rule-on "WIP ac on" || return # from 107
  amend-rule-test-mode-on "living-room-ac-on" || return # from 111
  git-amend-commit

  commit-DELETE-thermometer-test-value "26°C" || return # from 111
  commit-DELETE-balcony-test-value "door-closed" || return # from 111

  commit-living-room-ac-rule-off "WIP ac off" || return # from 107
  amend-rule-test-mode-on "living-room-ac-off-temperature" || return # from 111
  git-amend-commit

  commit-DELETE-thermometer-test-value "19°C" || return # from 111

  commit-living-room-ac-rule-on-off-balcony-door "WIP ac on/off + balcony-door" || return # from 107
  amend-rule-test-mode-on "living-room-ac-off-balcony" || return
  git-amend-commit

  commit-DELETE-thermometer-test-value "26°C" || return # from 111
  commit-DELETE-balcony-test-value "door-opened" || return # from 111
}

run-init-exercise "$@"
