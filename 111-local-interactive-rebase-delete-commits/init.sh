#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/110-local-interactive-rebase-split-commits/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo "$exerciseDir" "$thisDir/README.md" || return

  init-ac-automation-branch || return #from 106
  wip-commits-ac-automation || return
}

wip-commits-ac-automation() {
  commit-empty-automation-rules || return # from 104

  define-device-traits || return # from 103
  commit-living-room-ac || return # from 104

  commit-living-room-sensors-thermometer || return # from 107
  commit-DELETE-thermometer-test-value "26°C" || return
  commit-living-room-ac-rule-on || return # from 107
  commit-DELETE-ac-rule-on-test-mode || return
  commit-DELETE-thermometer-test-value "24°C" || return
  commit-living-room-ac-rule-off || return # from 107
  commit-DELETE-ac-rule-off-test-mode || return
  commit-DELETE-thermometer-test-value "19°C" || return
  commit-living-room-sensors-balcony-door || return # from 107
  commit-DELETE-balcony-test-value "door-closed" || return
  commit-living-room-ac-rule-on-off-balcony-door || return # from 107
  commit-DELETE-ac-rule-off-balcony-door-test-mode || return
  commit-DELETE-thermometer-test-value "26°C" || return
  commit-DELETE-balcony-test-value "door-opened" || return
}

commit-DELETE-thermometer-test-value() {
  amend-sensor-test-value "living-room-thermostat-sensor" "$1" || return
  git-commit "DELETE! thermometer test value $1"
}

amend-sensor-test-value() {
  json-edit devices.json '.devices |= map(
    if .id == $deviceId then
      to_entries
        | map(if .key == "type" then [{key:"sensorTestValue", value:$sensorTestValue}, .] else [.] end)
        | flatten
        | from_entries
    else . end
  )' --arg deviceId "$1" --arg sensorTestValue "$2"
}

commit-DELETE-ac-rule-on-test-mode() {
  amend-rule-test-mode-on "living-room-ac-on" || return
  git-commit "DELETE! ac on testmode"
}

amend-rule-test-mode-on() {
  json-edit automation-rules.json '.rules |= map(
    if .id == $ruleId then
      to_entries
        | map(if .key == "when" then [{key:"testMode", value:true}, .] else [.] end)
        | flatten
        | from_entries
    else . end
  )' --arg ruleId "$1"
}

commit-DELETE-ac-rule-off-test-mode() {
  amend-rule-test-mode-on "living-room-ac-off-temperature" || return
  git-commit "DELETE! ac off testmode"
}

commit-DELETE-balcony-test-value() {
  amend-sensor-test-value "living-room-balcony-door" "$1" || return
  git-commit "DELETE! balcony-door test value $1"
}

commit-DELETE-ac-rule-off-balcony-door-test-mode() {
  amend-rule-test-mode-on "living-room-ac-off-balcony" || return
  git-commit "DELETE! ac on/off with balcony-door testmode"
}

run-init-exercise "$@"
