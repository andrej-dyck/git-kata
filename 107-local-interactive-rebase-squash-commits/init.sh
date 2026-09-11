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
  commit-empty-automation-rules || return # from 103
  commit-living-room-ac || return # from 104
  commit-device-traits-schema "fixup! devices schema" || return # from 106
  commit-living-room-sensors-thermometer "install living-room sensors" || return
  commit-living-room-ac-rule-on || return
  commit-living-room-ac-rule-off || return
  commit-living-room-sensors-balcony-door "amend! install living-room sensors" || return
  commit-living-room-ac-rule-on-off-balcony-door || return
}

commit-living-room-ac-rule-on() {
  define-living-room-ac-on-rule || return # from 105
  git-commit "${1:-automate turning on living-room AC}"
}

commit-living-room-ac-rule-off() {
  define-living-room-ac-rule-off-rule || return # from 105
  git-commit "${1:-automate turning off living-room AC}"
}

commit-living-room-ac-rule-on-off-balcony-door() {
  define-living-room-ac-rule-on-off-balcony-door-rule || return
  git-commit "${1:-automate turning on/off living-room AC w/ balcony door}"
}

run-init-exercise "$@"
