source ../scripts/#kata-scripts.sh
source ../104-local-rebase-onto-main/init-functions.sh

init-exercise() {
  clean-exercise-repo

  local feature="fuel-estimation"

  git-feature-branch "$feature"

  copy-rsc RocketFuelPart1/RocketFuel.md
  commit-mass-and-fuel-types-in-one-commit
  commit-fuel-estimation
}

commit-mass-and-fuel-types-in-one-commit() {
  copy-rsc RocketFuelPart0/src
  in-src remove-lines-in-file Fuel.kt 10 15
  in-src remove-lines-in-file Fuel.kt 3 4
  git-commit "Add mass and fuel types"
}
