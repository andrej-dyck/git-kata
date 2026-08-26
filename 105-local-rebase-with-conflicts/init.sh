#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/104-local-rebase-onto-main/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo "$exerciseDir" "$thisDir/README.md" || return

  # main
  commit-empty-rooms || return # from 101
  commit-living-room || return # from 102
  commit-empty-devices || return # from 103
  commit-living-room-devices || return #from 103

  # feature "living-room-automation"
  feature-living-room-automation-rules "living-room-automation" || return # from 104
  commit-living-room-wall-lamp || return
  commit-living-room-wall-lamp-rules || return

  # additional work on main
  git-checkout-main || return
  integrated-ac-install-commits || return # from 104
  commit-empty-automation-rules || return # from 104
  commit-living-room-ac-rules || return

  # start task on branch "living-room-automation"
  git-checkout-branch "living-room-automation" || return
}

commit-living-room-wall-lamp() {
  json-edit devices.json '.devices += [{
    "id": "living-room-wall-lamp",
    "name": "Living-room wall lamp",
    "roomId": "living-room",
    "type": "light",
    "traits": ["on-off", "brightness-control"]
  }]' || return

  git-commit "install living-room wall lamp"
}

commit-living-room-wall-lamp-rules() {
  json-edit automation-rules.json '.rules |= map(
    if .id == "living-room-lights-on-presence" then
      .then += [{ "deviceId": "living-room-wall-lamp", "action": "turn-on", "parameters": { "targetBrightnessLevel": 60 } }]
    else . end
  )' || return

  json-edit automation-rules.json '.rules |= map(
    if .id == "living-room-lights-off-no-presence" then
      .then += [{ "deviceId": "living-room-wall-lamp", "action": "turn-off" }]
    else . end
  )' || return

  json-edit automation-rules.json '.rules |= map(
    if .id == "living-room-lights-off-ambient-bright" then
      .then += [{ "deviceId": "living-room-wall-lamp", "action": "turn-off" }]
    else . end
  )' || return

  git-commit "automate turning on/off living room wall lamp"
}

commit-living-room-ac-rules() {
  json-edit automation-rules.json '.rules += [{
    "id": "living-room-ac-on",
    "name": "Turn on living-room AC when its hot",
    "when": [{
      "sensorDeviceId": "living-room-thermostat-sensor",
      "sensorValue": ">25°C"
    }, {
      "sensorDeviceId": "living-room-balcony-door",
      "event": "door-closed"
    }],
    "then": [{
      "deviceId": "living-room-ac",
      "action": "turn-on",
      "parameters": { "targetTemperatureCelsius": 21.0 }
    }]
  }]' || return
  json-edit automation-rules.json '.rules += [{
    "id": "living-room-ac-off",
    "name": "Turn off living-room AC when its cool",
    "when": [{
      "sensorDeviceId": "living-room-thermostat-sensor",
      "sensorValue": "<20°C"
    }],
    "then": [{
      "deviceId": "living-room-ac",
      "action": "turn-off",
    }]
  }]' || return
  json-edit automation-rules.json '.rules += [{
    "id": "living-room-ac-off",
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

  git-commit "automate living-room AC"
}

run-init-exercise "$@"
