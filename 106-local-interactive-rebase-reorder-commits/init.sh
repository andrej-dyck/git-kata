#!/bin/bash
source ../scripts/index.sh
source ../104-local-rebase-onto-main/init.sh

init-exercise() {
  clean-exercise-repo

  local feature="fuel-estimation"

  git-feature-branch "$feature"

  commit-mass-and-fuel-types
  commit-rocket-fuel-readme
  commit-fuel-estimation
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  init-exercise
fi
