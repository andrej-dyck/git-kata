#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/104-local-rebase-onto-main/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo "$exerciseDir" "$thisDir/README.md" || return

  # main
  commit-initial-work-on-main || return # from 103

  # feature "living-room-light-automation"
  feature-living-room-light-automation "living-room-light-automation" || return # from 104

  # additional work on main
  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  additional-work-on-main || return from 104
  commit-living-room-ac || return
  commit-living-room-sensors-thermometer || return
  commit-living-room-sensors-balcony-door || return

  # start task on branch "living-room-light-automation"
  git-switch-branch "living-room-light-automation" || return
}

commit-living-room-ac() {
  json-edit devices.json '.devices += [{
    "id": "living-room-ac",
    "name": "Living-room AC",
    "roomId": "living-room",
    "type": "ac-unit",
    "traits": ["on-off", "temperature-control"]
  }]' || return

  git-commit "${1:-install living-room AC}"
}

commit-living-room-sensors-thermometer() {
  install-living-room-thermometer || return
  git-commit "${1:-install living-room thermostat sensor}"
}

install-living-room-thermometer() {
  json-edit devices.json '.devices += [{
    "id": "living-room-thermostat-sensor",
    "name": "Living-room thermostat sensor",
    "roomId": "living-room",
    "type": "sensor"
  }]' || return
}

commit-living-room-sensors-balcony-door() {
  install-living-room-balcony-door-sensor || return
  git-commit "${1:-install living-room balcony-door sensor}"
}

install-living-room-balcony-door-sensor() {
  json-edit devices.json '.devices += [{
    "id": "living-room-balcony-door",
    "name": "Living-room balcony-door sensor",
    "roomId": "living-room",
    "type": "sensor"
  }]' || return
}

run-init-exercise "$@"
