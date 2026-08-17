#!/bin/bash
source ../scripts/index.sh
source ../104-local-rebase-onto-main/init.sh
source ../107-local-interactive-rebase-squash-commits/init.sh
source ../110-local-interactive-rebase-split-commits/init.sh

init-exercise() {
  clean-exercise-repo

  local feature="fuel-estimation"

  git-feature-branch "$feature"

  commit-rocket-fuel-readme
  commit-mass-and-fuel-types-in-one-commit
  commit-tmp-main
  commit-fuel-estimation-and-unit-tests
}

commit-tmp-main() {
  copy-to-src RocketFuelPart0/tmp-main.kt
  git-commit "REMOVE! tmp main for drafting"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  init-exercise
fi
