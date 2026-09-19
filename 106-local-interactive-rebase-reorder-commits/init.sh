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

  # another feature "living-room-light-automation"
  feature-living-room-light-automation "living-room-light-automation" || return # from 104
  git-switch-main || return

  # feature "living-room-ac-automation"
  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  git-new-branch "living-room-ac-automation" || return
}

wip-commits-ac-automation() {
  commit-empty-automation-rules || return # from 103
  commit-living-room-ac || return # from 105
  commit-device-traits-schema || return # from 104
  commit-living-room-sensors-thermometer || return # from 105
  commit-living-room-ac-rules || return
  commit-living-room-sensors-balcony-door|| return # from 104
}

commit-living-room-ac-rules() {
  define-living-room-ac-on-rule || return
  define-living-room-ac-rule-off-rule || return
  define-living-room-ac-rule-on-off-balcony-door-rule || return

  git-commit "${1:-automate living-room AC}"
}

define-living-room-ac-on-rule() {
  json-edit automation-rules.json '.rules += [{
    "id": "living-room-ac-on",
    "name": "Turn on living-room AC when its hot",
    "when": [{
      "sensorDeviceId": "living-room-thermostat-sensor",
      "sensorValue": ">25°C"
    }],
    "then": [{
      "deviceId": "living-room-ac",
      "action": "turn-on",
      "parameters": { "targetTemperatureCelsius": 21.0 }
    }]
  }]'
}

define-living-room-ac-rule-off-rule() {
  json-edit automation-rules.json '.rules += [{
    "id": "living-room-ac-off-temperature",
    "name": "Turn off living-room AC when its cool",
    "when": [{
      "sensorDeviceId": "living-room-thermostat-sensor",
      "sensorValue": "<20°C"
    }],
    "then": [{
      "deviceId": "living-room-ac",
      "action": "turn-off",
    }]
  }]'
}

define-living-room-ac-rule-on-off-balcony-door-rule() {
  json-edit automation-rules.json '.rules |= map(
    if .id == "living-room-ac-on" then
      .when += [{ "sensorDeviceId": "living-room-balcony-door", "event": "door-closed" }]
    else . end
  )' || return

  json-edit automation-rules.json '.rules += [{
    "id": "living-room-ac-off-balcony",
    "name": "Turn off living-room AC when balcony door open",
    "when": [{
      "sensorDeviceId": "living-room-balcony-door",
      "event": "door-opened"
    }],
    "then": [{
      "deviceId": "living-room-ac",
      "action": "turn-off",
    }]
  }]' || return
}

run-init-exercise "$@"
