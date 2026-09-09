#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/103-local-undo-last-commit/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo-with-origin "$exerciseDir" "$thisDir/README.md" || return

  # main
  commit-empty-rooms || return # from 101
  commit-living-room || return # from 102
  commit-empty-devices || return # from 103
  commit-living-room-devices || return # from 103
  git-push

  # feature "living-room-lights-automation"
  wip-feature-lights-automation "living-room-lights-automation" || return # from 103
  git-push-new-branch "living-room-lights-automation"

  # final changes (uncommited)
  define-lights-on-off-ambient-light-rule || return
}

wip-feature-lights-automation() {
  git-new-branch "$1" || return

  commit-living-room-light-traits || return # from 103
  commit-empty-automation-rules || return # from 103
  commit-wip-automation-rule || return
}

commit-wip-automation-rule() {
  define-lights-on-presence-rule || return
  define-lights-off-presence-rule || return

  git-commit "WIP automation rules"
}

run-init-exercise "$@"
