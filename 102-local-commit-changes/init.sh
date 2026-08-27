#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/101-local-amend-commit/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo "$exerciseDir" "$thisDir/README.md" || return

  commit-empty-rooms || return # from 101
  commit-living-room || return
  commit-empty-devices-with-mistake || return
  work-on-devices-with-fix || return
}

commit-living-room() {
  json-edit rooms.json '.rooms += [{ "id": "living-room", "name": "Living room" }]' || return

  git-commit "register living room"
}

commit-empty-devices-with-mistake() {
  copy-rsc "smart-home-templates/devices.schema.json" ./ || return
  copy-rsc "smart-home-templates/empty-devices.json" devices.json || return

  json-edit devices.schema.json 'del(.properties.devices.items.properties.traits)' # we will add traits later
  json-edit devices.json '."$schema" = "devices_schema.json"' || return # the mistake

  git-commit "define devices schema"
}

work-on-devices-with-fix() {
  json-edit devices.json '."$schema" = "devices.schema.json"' || return
  install-living-room-light || return
}

install-living-room-light() {
  json-edit devices.json '.devices += [{
    "id": "living-room-light",
    "name": "Living-room light",
    "roomId": "living-room",
    "type": "light"
  }]' || return
}

run-init-exercise "$@"
