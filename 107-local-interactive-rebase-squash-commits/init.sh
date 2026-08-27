#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/106-local-interactive-rebase-reorder-commits/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo "$exerciseDir" "$thisDir/README.md" || return

  init-ac-automation-branch || return #from 106
  wip-commits-ac-automation || return
}

wip-commits-ac-automation() {
  commit-empty-automation-rules || return # from 104
  commit-living-room-ac || return       # from 104
  commit-fix-devices-schema || return
  commit-living-room-sensors-1 || return
  commit-living-room-ac-rule-1 || return
  commit-living-room-ac-rule-2 || return
  commit-living-room-sensors-2 || return
  commit-living-room-ac-rule-3 || return
}

commit-fix-devices-schema() {
  copy-rsc "smart-home-templates/devices.schema.json" ./ || return
  git-commit "fixup! devices schema"
}

commit-living-room-sensors-1() {
  install-living-room-balcony-door-sensor || return
  git-commit "install living-room sensors"
}

commit-living-room-sensors-2() {
  install-living-room-thermometer || return
  git-commit "amend! install living-room sensors"
}

commit-living-room-ac-rule-1() {
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
  }]' || return

  git-commit "automate turning on living-room AC"
}

commit-living-room-ac-rule-2() {
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

  git-commit "automate turning off living-room AC"
}

commit-living-room-ac-rule-3() {
  json-edit automation-rules.json '.rules |= map(
      if .id == "living-room-ac-on" then
        .when += [{ "sensorDeviceId": "living-room-balcony-door", "event": "door-closed" }]
      else . end
    )' || return

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

  git-commit "automate turning off living-room AC when balcony door opens"
}

run-init-exercise "$@"
