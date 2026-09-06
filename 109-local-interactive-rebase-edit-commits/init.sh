#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/108-local-interactive-rebase-reword-commits/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo "$exerciseDir" "$thisDir/README.md" || return

  init-ac-automation-branch || return #from 106
  wip-commits-ac-automation || return
}

wip-commits-ac-automation() {
  commit-empty-automation-rules || return # from 104
  commit-device-traits-schema || return # from 106
  commit-living-room-ac || return # from 104
  amend-ac-id || return
  commit-living-room-sensors || return # from 106
  commit-living-room-ac-rules || return # from 105
  amend-ac-rules-deviceId || return
}

amend-ac-id() {
  json-edit devices.json '.devices |= map(
    if .id == "living-room-ac" then
      .id |= "ac" | .name |= "AC"
    else . end
  )' || return

  git-amend-commit
}

amend-ac-rules-deviceId() {
  json-edit automation-rules.json '
    def mapDeviceId:
      .then |= map(
        if .deviceId == "living-room-ac" then
          .deviceId = "ac"
        else
          .
        end
      );

    .rules |= map(
      if .id == "living-room-ac-on" then
        .id = "ac-on" | mapDeviceId
      elif .id == "living-room-ac-off-temperature" then
        .id = "ac-off-temperature" | mapDeviceId
      elif .id == "living-room-ac-off-balcony" then
        .id = "ac-off-balcony" | mapDeviceId
      else
        .
      end
    )
  ' || return

  git-amend-commit
}

run-init-exercise "$@"
