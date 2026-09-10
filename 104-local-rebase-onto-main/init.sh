#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/103-local-undo-last-commits/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo "$exerciseDir" "$thisDir/README.md" || return

  # main
  commit-empty-rooms || return # from 101
  commit-living-room || return # from 102
  commit-empty-devices || return # from 103
  commit-living-room-devices || return #from 103

  # feature "living-room-light-automation"
  feature-living-room-light-automation "living-room-light-automation" || return

  # additional work on main
  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  git-switch-main || return
  integrated-ac-install-commits || return
  commit-empty-automation-rules || return # from 103

  # start task on branch "living-room-light-automation"
  git-switch-branch "living-room-light-automation" || return
}

feature-living-room-light-automation() {
  git-new-branch "$1" || return

  commit-living-room-light-traits || return # from 103
  commit-empty-automation-rules || return # from 103
  commit-living-room-light-rules || return
}

commit-living-room-light-rules() {
  define-lights-on-presence-rule || return
  define-lights-off-presence-rule || return
  define-lights-on-off-ambient-light-rule || return

  git-commit "automate living-room light"
}

integrated-ac-install-commits() {
  define-device-traits || return # from 103
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

  git-commit "${1:-install living-room AC}"
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
