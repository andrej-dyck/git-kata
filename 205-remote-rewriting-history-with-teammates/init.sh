#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/204-remote-interactive-rebase/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo-with-origin "$exerciseDir" "$thisDir/README.md" || return

  push-initial-work-on-main-and-feature "living-room-ac-automation" || return # from 204

  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  continue-wip-commits-ac-automation "living-room-ac-automation" || return

  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  cleaned-up-origin "living-room-ac-automation" \
    clean-ac-automation-commits \
    || return
}

continue-wip-commits-ac-automation() {
  git-switch-branch "$1" || return

  commit-empty-automation-rules || return # from 103

  commit-living-room-ac-rule-on "WIP ac on" || return # from 107
  amend-rule-test-mode-on "living-room-ac-on" || return # from 111
  git-amend-commit

  commit-DELETE-thermometer-test-value "26°C" || return # from 111

  commit-living-room-ac-rule-off "WIP ac off" || return # from 107
  amend-rule-test-mode-on "living-room-ac-off-temperature" || return # from 111
  git-amend-commit

  commit-DELETE-thermometer-test-value "19°C" || return # from 111
}

cleaned-up-origin() {
  git-switch-main
  git-new-branch "$1-clean" || return

  "$2" || return

  git push -q --force-with-lease -u origin "HEAD:$1"

  git-switch-branch "$1"
  git-force-delete-local-branch "$1-clean" || return
}

clean-ac-automation-commits() {
  commit-living-room-ac || return # from 104
  commit-living-room-sensors-thermometer || return # from 104
  commit-living-room-sensors-balcony-door || return # from 104
  commit-living-room-ac-rules || return # from 105
}

run-init-exercise "$@"
