source ../scripts/#kata-scripts.sh
source ../105-local-rebase-with-conflicts/init-functions.sh

init-exercise() {
  clean-exercise-repo

  local feature="fuel-estimation"

  git-feature-branch "$feature"

  commit-rocket-fuel-readme
  commit-mass-and-fuel-draft
  commit-wip-estimation
}

commit-wip-estimation() {
  copy-rsc RocketFuelPart0/src
  copy-rsc RocketFuelPart0/test

  in-src replace-in-file Mass.kt "inKg" "amount"
  in-src replace-in-file Fuel.kt "inKg" "amount"

  git-commit "WIP: estimation"
}