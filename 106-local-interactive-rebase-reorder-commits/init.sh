#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/105-local-rebase-with-conflicts/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo "$exerciseDir" "$thisDir/README.md" || return

  # main
  commit-empty-rooms || return # from 101
  commit-living-room || return # from 102
  commit-empty-devices || return # from 103
  commit-living-room-light  || return #from 103
  commit-living-room-presence-sensor || return # from 103
  commit-living-room-ambient-light-sensor || return # from 103

  # another feature "living-room-automation"
  feature-living-room-automation-rules "living-room-automation" || return
  git-checkout-main || return

  # feature "living-room-ac-automation"
  wip-feature-ac-automation "living-room-ac-automation" || return
}

wip-feature-ac-automation() {
  git-checkout-new-branch "$1" || return

  commit-empty-automation-rules || return # from 104
  commit-living-room-ac || return # from 104
  commit-device-traits-schema || return
  commit-living-room-ac-rules || return # from 105
  commit-living-room-sensors || return
}

commit-device-traits-schema() {
  copy-rsc "smart-home-templates/devices.schema.json" ./ || return
  git-commit "define traits for devices"
}

commit-living-room-sensors() {
  install-living-room-balcony-door-sensor || return # from 104
  install-living-room-thermometer || return # from 104
  git-commit "install living-room sensors"
}

run-init-exercise "$@"
