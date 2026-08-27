#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/103-local-undo-last-commit/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo "$exerciseDir" "$thisDir/README.md" || return

  # main
  commit-empty-rooms || return # from 101
  commit-living-room || return # from 102
  commit-empty-devices || return # from 103
  commit-living-room-devices || return #from 103

  # feature "living-room-automation"
  feature-living-room-automation-rules "living-room-automation" || return

  # additional work on main
  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  git-checkout-main || return
  integrated-ac-install-commits || return
  commit-empty-automation-rules || return # from 103

  # start task on branch "living-room-automation"
  git-checkout-branch "living-room-automation" || return
}

feature-living-room-automation-rules() {
  git-checkout-new-branch "$1" || return

  commit-living-room-light-traits || return
  commit-empty-automation-rules || return # from 103
  commit-living-room-light-rules || return
}

commit-living-room-light-traits() {
  copy-rsc "smart-home-templates/devices.schema.json" ./ || return
  json-edit devices.json '.devices |= map(
    if .id == "living-room-light" then . +{ "traits": ["on-off", "brightness-control"] } else . end
  )' || return

  git-commit "define living-room-light trait on-off"
}

commit-living-room-light-rules() {
  json-edit automation-rules.json '.rules += [{
    "id": "living-room-lights-on-presence",
    "name": "Turn on living-room lights when presence is detected",
    "when": [{
      "sensorDeviceId": "living-room-presence",
      "event": "presence-detected"
    }, {
      "sensorDeviceId": "living-room-ambient-light",
      "sensorValue": "is-dark"
    }],
    "then": [{
      "deviceId": "living-room-light",
      "action": "turn-on"
    }]
  }]' || return

  json-edit automation-rules.json '.rules += [{
    "id": "living-room-lights-off-no-presence",
    "name": "Turn off living room lights when presence is no longer detected",
    "when": [{
      "sensorDeviceId": "living-room-presence",
      "event": "presence-cleared"
    }],
    "then": [{
      "deviceId": "living-room-light",
      "action": "turn-off"
    }]
  }]' || return

  json-edit automation-rules.json '.rules += [{
    "id": "living-room-lights-off-ambient-bright",
    "name": "Turn off living room lights when ambient light is bright",
    "when": [{
      "sensorDeviceId": "living-room-ambient-light",
      "sensorValue": "is-bright"
    }],
    "then": [{
      "deviceId": "living-room-light",
      "action": "turn-off"
    }]
  }]' || return

  git-commit "automate turning on/off the living-room light"
}

integrated-ac-install-commits() {
  copy-rsc "smart-home-templates/devices.schema.json" ./ || return
  commit-living-room-ac || return
  commit-balcony-door-sensor || return
  commit-living-room-thermometer || return
}

commit-living-room-ac() {
  json-edit devices.json '.devices += [{
    "id": "living-room-ac",
    "name": "Living-room AC",
    "roomId": "living-room",
    "type": "ac-unit",
    "traits": ["on-off", "temperature-control"]
  }]' || return

  git-commit "install living-room AC"
}

commit-balcony-door-sensor() {
  install-living-room-balcony-door-sensor || return

  git-commit "install living-room balcony-door sensor"
}

install-living-room-balcony-door-sensor() {
  json-edit devices.json '.devices += [{
    "id": "living-room-balcony-door",
    "name": "Living-room balcony-door sensor",
    "roomId": "living-room",
    "type": "sensor"
  }]' || return
}

commit-living-room-thermometer() {
  install-living-room-thermometer || return

  git-commit "install living-room thermostat sensor"
}

install-living-room-thermometer() {
  json-edit devices.json '.devices += [{
    "id": "living-room-thermostat-sensor",
    "name": "Living-room thermostat sensor",
    "roomId": "living-room",
    "type": "sensor"
  }]' || return
}

run-init-exercise "$@"
