#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/301-advanced-interactive-rebase-onto-a-rewritten-branch/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo-with-origin "$exerciseDir" "$thisDir/README.md" || return

  push-initial-work-on-main-and-feature "living-room-ac-automation" || return # from 204

  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  continue-wip-commits-ac-automation "living-room-ac-automation" || return # from 301

  merge-main-with-conflict-resolution resolve-automation-rules-conflicts || return
  git-push || return

  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  git-switch-main || return
  advance-main-with-light-automation
  git-push || return

  sleep 1 # required so git log shows the same history as 'Initial Git History' of the README
  git-switch-branch "living-room-ac-automation" || return
  continue-wip-commits-ac-automation-balcony-door || return
  git-push || return

  git-merge-expecting-conflicts || return
}

merge-main-with-conflict-resolution() {
  local resolveFn="$1"

  git-merge-expecting-conflicts || return

  $resolveFn || return
  git commit --quiet --no-edit
}

git-merge-expecting-conflicts() {
  if git merge --quiet origin/main >/dev/null 2>&1; then
    return 0
  fi

  if git diff --name-only --diff-filter=U | grep -q .; then
    return 0 # merge error due to conflicts is expected
  fi

  echo "Unexpected merge failure" >&2
  return 1
}

resolve-automation-rules-conflicts() {
  # 'automation-rules.schema.json' on `main` is more complete; so, take theirs
  git checkout --theirs -- automation-rules.schema.json || return
  git add --force -- automation-rules.schema.json || return

  # our 'automation-rules.json' has AC rules defined; so, take ours
  git checkout --ours -- automation-rules.json || return
  git add --force -- automation-rules.json || return
}

advance-main-with-light-automation() {
  commit-living-room-presence-sensor || return # from 103
  commit-living-room-ambient-light-sensor || return # from 103
  commit-living-room-light-traits || return # from 103
  commit-living-room-light-rules || return # from 104
}

continue-wip-commits-ac-automation-balcony-door() {
  commit-DELETE-thermometer-test-value "26°C" || return # from 111
  commit-DELETE-thermometer-test-value "19°C" || return # from 111

  commit-living-room-sensors-balcony-door "install balcony door" || return # from 110

  commit-living-room-ac-rule-on-off-balcony-door "WIP ac on/off + balcony door" || return # from 107
  amend-rule-test-mode-on "living-room-ac-off-balcony" || return # from 111
  git-amend-commit

  commit-DELETE-balcony-test-value "door-closed" || return
  commit-DELETE-thermometer-test-value "26°C" || return
  commit-DELETE-balcony-test-value "door-opened" || return
}

run-init-exercise "$@"
