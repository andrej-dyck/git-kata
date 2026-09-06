#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/109-local-interactive-rebase-edit-commits/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo "$exerciseDir" "$thisDir/README.md" || return

  init-ac-automation-branch || return #from 106
  wip-commits-ac-automation || return
}

wip-commits-ac-automation() {
  commit-empty-automation-rules || return # from 104
  define-device-traits || return # from 103
  commit-living-room-ac || return # from 104
  commit-living-room-sensors || return # from 106
  commit-living-room-ac-rules || return # from 105
}

run-init-exercise "$@"
