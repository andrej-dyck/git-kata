#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/205-remote-rewriting-history-with-teammates/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo-with-origin "$exerciseDir" "$thisDir/README.md" || return

  push-initial-work-on-main-and-feature "living-room-ac-automation" || return # from 204

  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  continue-wip-commits-ac-automation "living-room-ac-automation" || return

  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  cleaned-up-origin "living-room-ac-automation" \
    origin-ac-automation-commits \
    || return # from 205

  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  continue-wip-commits-ac-automation-balcony-door "living-room-ac-automation" || return
}

push-initial-work-on-main-and-feature() {
  # main
  commit-initial-work-on-main || return # from 203
  git-push || push

  # feature "living-room-ac-automation"
  git-new-branch "$1" || return
  define-device-traits || return # from 103
  commit-living-room-ac "install ac" || return # from 104
  commit-living-room-sensors-thermometer "install thermostat" || return # from 110
  git-push-new-branch "$1" || return

  # advance main
  git-switch-main || return
  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  commit-device-traits-schema || return # from 106
  commit-empty-automation-rules || return # from 103
  git-push || return
}

continue-wip-commits-ac-automation() {
  git-switch-branch "$1" || return

  commit-empty-automation-rules "WIP automation rules schema" || return # from 103
  json-edit automation-rules.schema.json '
    .properties.rules.items.properties |= (
      del(.enabled)
      | del(.when.items.properties.time)
      | del(.when.items.properties.days)
      | .then.items.properties.action.enum |= ["turn-on", "turn-off"]
      | .then.items.properties.parameters.properties|= [{ "targetTemperatureCelsius": { "type": "number", "minimum": 10.0, "maximum": 30.0 } }]
    )
  ' || return
  git-amend-commit

  commit-living-room-ac-rule-on "WIP ac on" || return # from 107
  amend-rule-test-mode-on "living-room-ac-on" || return # from 111
  git-amend-commit

  commit-living-room-ac-rule-off "WIP ac off" || return # from 107
  amend-rule-test-mode-on "living-room-ac-off-temperature" || return # from 111
  git-amend-commit
}

origin-ac-automation-commits() {
  commit-living-room-ac || return # from 104
  commit-living-room-sensors-thermometer || return # from 104

  define-living-room-ac-on-rule || return
  define-living-room-ac-rule-off-rule || return
  git-commit "automate living-room AC"
}

continue-wip-commits-ac-automation-balcony-door() {
  commit-living-room-sensors-balcony-door "install balcony door" || return # from 110

  commit-living-room-ac-rule-on-off-balcony-door "WIP ac on/off + balcony door" || return # from 107
  amend-rule-test-mode-on "living-room-ac-off-balcony" || return
  git-amend-commit
}

run-init-exercise "$@"
