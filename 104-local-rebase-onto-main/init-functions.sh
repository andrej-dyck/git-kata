source ../scripts/#kata-scripts.sh

init-exercise() {
  clean-exercise-repo

  local feature="fuel-estimation"
  work-on-feature-branch "$feature"

  git-checkout-main
  commit-rocket-fuel-readme
  git-checkout-feature "$feature"
}

work-on-feature-branch() {
  git-feature-branch "$1"

  commit-mass-and-fuel-types
  commit-fuel-estimation
}

commit-mass-and-fuel-types() {
  copy-to-src RocketFuelPart0/src/Mass.kt
  git-commit "Add mass type"

  copy-to-src RocketFuelPart0/src/Fuel.kt
  in-src remove-lines-in-file Fuel.kt 10 15
  in-src remove-lines-in-file Fuel.kt 3 4
  git-commit "Add fuel type"
}

commit-fuel-estimation() {
  copy-to-src RocketFuelPart0/src/Fuel.kt
  copy-rsc RocketFuelPart0/test
  git-commit "Estimate fuel based on mass"
}

commit-rocket-fuel-readme() {
  copy-rsc RocketFuelPart1/RocketFuel.md
  git-commit "Add rocket fuel readme"
}