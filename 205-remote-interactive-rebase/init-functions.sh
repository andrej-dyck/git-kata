source ../scripts/#kata-scripts.sh
source ../107-local-interactive-rebase-squash-commits/init-functions.sh
source ../108-local-interactive-rebase-reword-commits/init-functions.sh
source ../110-local-interactive-rebase-split-commits/init-functions.sh
source ../111-local-interactive-rebase-delete-commits/init-functions.sh

init-exercise() {
  cloned-exercise-repo

  local feature="fuel-estimation"

  git-feature-branch "$feature"

  commit-mass-and-fuel-types-in-one-commit
  commit-incomplete-readme
  commit-first-estimate-formula-draft
  commit-tmp-main
  commit-estimate-unit-tests
  commit-fix-estimation-formula
  commit-wip-min-requirement

  git-push-feature-branch "$feature"

  # un-committed work
  copy-rsc RocketFuelPart1/RocketFuel.md
  copy-to-src RocketFuelPart1/src/Fuel.kt
  copy-to-src RocketFuelPart1/src/RocketFuelEstimate.kt
}

commit-fix-estimation-formula() {
  copy-to-src RocketFuelPart0/src/Fuel.kt
  git-commit "squash! fix estimate"
}

commit-wip-min-requirement() {
  copy-to-src RocketFuelPart1/src/Mass.kt
  copy-to-src RocketFuelPart1/src/RocketFuelEstimate.kt
  copy-rsc RocketFuelPart1/test

  in-src replace-in-file RocketFuelEstimate.kt "Fuel =" "Fuel = TODO()"
  in-src remove-lines-in-file RocketFuelEstimate.kt 6 6

  git-commit "WIP min required fuel"
}