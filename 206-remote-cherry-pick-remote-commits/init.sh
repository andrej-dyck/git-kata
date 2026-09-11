#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/204-remote-interactive-rebase/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo-with-origin "$exerciseDir" "$thisDir/README.md" || return

  # main
  commit-initial-work-on-main || return # from 203
  git-push

  # feature "living-room-light-automation"
  feature-living-room-light-automation "living-room-light-automation" || return # from 104
  git-push-new-branch "living-room-light-automation"

  # start feature "living-room-light-automation"
  git-switch-main || return
  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  git-new-branch "living-room-ac-automation" || return
  start-commits-ac-and-sensors || return # from 204
  git-push-new-branch "living-room-ac-automation"

  # prepare feature "automation-schema"
  git-switch-main || return
  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  git-new-branch "automation-schema" || return

  # remove local copies of branches
  git-force-delete-local-branch "living-room-light-automation"
  git-force-delete-local-branch "living-room-ac-automation"
}

run-init-exercise "$@"
