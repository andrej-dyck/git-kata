#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo "$exerciseDir" "$thisDir/README.md" || return

  commit-empty-rooms || return
  commit-living-room-with-mistake || return
}

commit-empty-rooms() {
  copy-rsc "smart-home-templates/rooms.schema.json" ./ || return
  copy-rsc "smart-home-templates/empty-rooms.json" rooms.json || return

  git-commit "define rooms schema"
}

commit-living-room-with-mistake() {
  json-edit rooms.json '.rooms += ["living-room"]' || return # the mistake

  git-commit "add living room to rooms"
}

run-init-exercise "$@"
