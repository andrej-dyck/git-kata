#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/111-local-interactive-rebase-delete-commits/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo-with-origin "$exerciseDir" "$thisDir/README.md" || return

  # main
  commit-initial-work-on-main || return # from 203
  git-push || push

  # feature "origin/living-room-ac-automation"
  ac-automation-WIP-commits-on-origin "living-room-ac-automation" || return

  # feature "living-room-ac-automation" (local)
  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  ac-automation-clean-branch "living-room-ac-automation" || return

  # advance main
  git-switch-main || return
  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  commit-device-traits-schema || return # from 106
  commit-empty-automation-rules || return # from 103
  git-push || return

  # start task on branch "living-room-ac-automation"
  git-switch-branch "living-room-ac-automation" || return
  git reset -q --hard origin/main || return
}

ac-automation-WIP-commits-on-origin() {
  git-new-branch "$1" || return
  commit-living-room-ac "install ac" || return # from 104
  commit-living-room-sensors "WIP sensors" || return # from 110
  amend-sensor-test-value "living-room-thermostat-sensor" "26°C" || return # from 111
  git-amend-commit
  amend-sensor-test-value "living-room-balcony-door" "door-closed" || return # from 111
  git-amend-commit
  commit-empty-automation-rules || return # from 103
  commit-living-room-ac-rule-on "WIP ac on" || return # from 107
  amend-rule-test-mode-on "living-room-ac-on" || return # from 111
  git-amend-commit
  git-push-new-branch "$1" || return
}

ac-automation-clean-branch() {
  git-switch-branch "$1" || return
  git reset -q --hard origin/main || return

  commit-living-room-ac || return # from 104
  commit-living-room-sensors-thermometer || return # from 104
  commit-empty-automation-rules || return # from 103
  commit-living-room-ac-rule-on || return # from 107
  commit-living-room-ac-rule-off || return # from 107
  commit-living-room-sensors-balcony-door || return # from 104
  commit-living-room-ac-rule-on-off-balcony-door || return # from 107
}

run-init-exercise "$@"
