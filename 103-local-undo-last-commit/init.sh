#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/102-local-commit-changes/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo "$exerciseDir" "$thisDir/README.md" || return

  # main
  commit-empty-rooms || return # from 101
  commit-living-room || return # from 102
  commit-empty-devices || return
  commit-living-room-devices || return

  # feature "living-room-automation"
  wip-feature-automation-rules "living-room-automation" || return
}

commit-empty-devices() {
  copy-rsc "smart-home-templates/devices.schema.json" ./ || return
  copy-rsc "smart-home-templates/empty-devices.json" devices.json || return

  json-edit devices.schema.json 'del(.properties.devices.items.properties.traits)'

  git-commit "define devices schema"
}

commit-living-room-devices() {
  commit-living-room-light || return
  commit-living-room-presence-sensor || return
  commit-living-room-ambient-light-sensor || return
}

commit-living-room-light() {
  install-living-room-light || return # from 102

  git-commit "install living-room light"
}

commit-living-room-presence-sensor() {
  json-edit devices.json '.devices += [{
    "id": "living-room-presence",
    "name": "Living-room presence sensor",
    "roomId": "living-room",
    "type": "sensor"
  }]' || return

  git-commit "install living-room presence sensor"
}

commit-living-room-ambient-light-sensor() {
  json-edit devices.json '.devices += [{
    "id": "living-room-ambient-light",
    "name": "Living-room ambient-light sensor",
    "roomId": "living-room",
    "type": "sensor"
  }]' || return

  git-commit "install living-room ambient-light sensor"
}

wip-feature-automation-rules() {
  git-checkout-new-branch "$1" || return

  commit-living-room-light-traits || return
  commit-empty-automation-rules || return
  commit-wip-automation-rule || return
}

commit-living-room-light-traits() {
  copy-rsc "smart-home-templates/devices.schema.json" ./ || return
  json-edit devices.json '.devices |= map(
    if .id == "living-room-light" then . +{ "traits": ["on-off", "brightness-control"] } else . end
  )' || return

  git-commit "define living-room-light trait on-off"
}

commit-empty-automation-rules() {
  copy-rsc "smart-home-templates/automation-rules.schema.json" ./ || return
  copy-rsc "smart-home-templates/empty-automation-rules.json" automation-rules.json || return

  git-commit "define automation-rules schema"
}

commit-wip-automation-rule() {
  json-edit automation-rules.json '.rules += [{
    "id": "living-room-lights-on-presence",
    "name": "Turn on living-room lights when presence is detected",
    "testMode": true,
    "when": [{
      "sensorDeviceId": "living-room-presence",
      "event": "presence-detected"
    }],
    "then": [{
      "deviceId": "living-room-light",
      "action": "turn-on"
    }]
  }]' || return

  git-commit "WIP automate turning on the living-room light"

  json-edit automation-rules.json '.rules += [{
    "id": "living-room-lights-off-no-presence",
    "name": "Turn off living room lights when presence is no longer detected",
    "testMode": true,
    "when": [{
      "sensorDeviceId": "living-room-presence",
      "event": "presence-cleared"
    }],
    "then": [{
      "deviceId": "living-room-light",
      "action": "turn-off"
    }]
  }]' || return

  git-commit "WIP automate turning off the living-room light"

  json-edit automation-rules.json '.rules |= map(
    if .id == "living-room-lights-on-presence" then
      .when += [{ "sensorDeviceId": "living-room-ambient-light", "sensorValue": "is-dark" }]
    else . end
  )' || return

  json-edit automation-rules.json '.rules += [{
    "id": "living-room-lights-off-ambient-bright",
    "name": "Turn off living room lights when ambient light is bright",
    "testMode": true,
    "when": [{
      "sensorDeviceId": "living-room-ambient-light",
      "sensorValue": "is-bright"
    }],
    "then": [{
      "deviceId": "living-room-light",
      "action": "turn-off"
    }]
  }]' || return

  git-commit "WIP automate turning on/off the living-room light based on ambient light"
}

run-init-exercise "$@"
