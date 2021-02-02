source ../scripts/#kata-scripts.sh
source ../105-local-rebase-with-conflicts/init-functions.sh
source ../107-local-interactive-rebase-squash-commits/init-functions.sh
source ../108-local-interactive-rebase-reword-commits/init-functions.sh
source ../110-local-interactive-rebase-split-commits/init-functions.sh
source ../111-local-interactive-rebase-delete-commits/init-functions.sh

init-exercise() {
  cloned-exercise-repo

  local feature="fuel-estimation"

  git-feature-branch "$feature"

  commit-mass-and-fuel-with-amount-attribute
  commit-incomplete-readme
  commit-first-estimate-formula-draft-with-amount-attribute
  commit-tmp-main
  commit-estimate-unit-tests
  commit-fix-estimation-formula
  commit-wip-min-requirement

  git-push-feature-branch "$feature"

  # un-committed work
  copy-rsc RocketFuelPart1/src
  copy-rsc RocketFuelPart1/RocketFuel.md
}

commit-mass-and-fuel-with-amount-attribute() {
  commit-mass-and-fuel-types-in-one-commit
  replace-inKg-with-amount
  in-src git-amend-commit "Add types"
}

commit-first-estimate-formula-draft-with-amount-attribute() {
  commit-first-estimate-formula-draft
  replace-inKg-with-amount
  in-src git-amend-commit "added estimation formula"
}

commit-fix-estimation-formula() {
  copy-to-src RocketFuelPart0/src/Fuel.kt
  replace-inKg-with-amount
  git-commit "squash! fix estimate"
}

commit-wip-min-requirement() {
  copy-to-src RocketFuelPart1/src/Mass.kt
  copy-to-src RocketFuelPart1/src/RocketFuelEstimate.kt
  copy-rsc RocketFuelPart1/test

  replace-inKg-with-amount
  in-src replace-in-file RocketFuelEstimate.kt "Fuel =" "Fuel = TODO()"
  in-src remove-lines-in-file RocketFuelEstimate.kt 6 6

  git-commit "WIP min required fuel"
}