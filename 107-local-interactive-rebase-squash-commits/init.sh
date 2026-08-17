#!/bin/bash
source ../scripts/index.sh
source ../104-local-rebase-onto-main/init.sh
source ../105-local-rebase-with-conflicts/init.sh

init-exercise() {
  clean-exercise-repo

  local feature="fuel-estimation"

  git-feature-branch "$feature"

  commit-mass-and-fuel-draft
  commit-incomplete-readme
  commit-fix-mass-fuel-terminology
  commit-fix-mass-and-fuel-to-be-double
  commit-fuel-estimation-and-unit-tests
  commit-link-with-readme
}

commit-fuel-estimation-and-unit-tests() {
  copy-to-src RocketFuelPart0/src/Fuel.kt
  git-commit "Estimate fuel based on mass"

  commit-estimate-unit-tests
}

commit-estimate-unit-tests() {
  copy-rsc RocketFuelPart0/test
  git-commit "Add estimation unit tests"
}

commit-incomplete-readme() {
  copy-rsc RocketFuelPart1/RocketFuel.md

  remove-lines-in-file RocketFuel.md 2 3
  git-commit "Add rocket fuel readme"
}

commit-link-with-readme() {
  copy-rsc RocketFuelPart1/RocketFuel.md
  git-commit "Fix missing link in rocket fuel readme"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  init-exercise
fi
