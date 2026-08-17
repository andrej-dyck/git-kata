#!/bin/bash
source ../scripts/index.sh
source ../104-local-rebase-onto-main/init.sh
source ../203-remote-rebase-onto-main/init.sh

init-exercise() {
  cloned-exercise-repo

  local feature="fuel-estimation"
  work-on-feature-branch "$feature"
  git-push-feature-branch "$feature"

  readme-pushed-to-origin-main

  git-checkout-feature "$feature"

  # mistake
  git reset --hard origin/main
  git push --force
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  init-exercise
fi
