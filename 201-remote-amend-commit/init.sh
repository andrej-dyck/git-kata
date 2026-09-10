#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/103-local-undo-last-commits/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo-with-origin "$exerciseDir" "$thisDir/README.md" || return

  commit-initial-work-on-main || return # from 103
  git-push

  wip-feature-lights-automation "living-room-light-automation" || return
  git-push-new-branch "living-room-light-automation"

  # uncommited changes to be amended
  changes-finalize-lights-on-off-rule || return
}

wip-feature-lights-automation() {
  git-new-branch "$1" || return

  commit-living-room-light-traits || return # from 103
  commit-empty-automation-rules || return # from 103
  commit-wip-automation-rule || return
}

commit-wip-automation-rule() {
  define-lights-on-presence-rule || return
  json-edit automation-rules.json '.rules |= map(
    if .id == "living-room-lights-on-presence" then
      to_entries
        | map(if .key == "when" then [{key:"testMode", value:true}, .] else [.] end)
        | flatten
        | from_entries
    else . end
  )' || return

  define-lights-off-presence-rule || return
  json-edit automation-rules.json '.rules |= map(
    if .id == "living-room-lights-off-no-presence" then
      to_entries
        | map(if .key == "when" then [{key:"testMode", value:true}, .] else [.] end)
        | flatten
        | from_entries
    else . end
  )' || return

  git-commit "WIP automation rules"
}

changes-finalize-lights-on-off-rule() {
  json-edit automation-rules.json '.rules |= map( del(.testMode) )' || return
  define-lights-on-off-ambient-light-rule || return # from 103
}

run-init-exercise "$@"
