#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/107-local-interactive-rebase-squash-commits/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo "$exerciseDir" "$thisDir/README.md" || return
  init-ac-automation-branch || return #from 106
  wip-commits-ac-automation || return
}

wip-commits-ac-automation() {
  commit-empty-automation-rules || return # from 104
  commit-living-room-ac "ac" || return # from 104
  commit-device-traits-schema "fix ac" || return # from 106
  commit-living-room-sensors "sensors" || return # from 106
  commit-living-room-ac-rules "WIP automation" || return # from 105
}

run-init-exercise "$@"
