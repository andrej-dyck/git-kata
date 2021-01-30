source ../scripts/#kata-scripts.sh
source ../104-local-rebase-onto-main/init-functions.sh

init-exercise() {
  clean-exercise-repo

  commit-rocket-fuel-readme
  commit-mass-and-fuel-draft

  local feature="fuel-estimation"
  git branch "feature/$feature"

  commit-conflicting-changes-on-main

  work-on-estimation "$feature"
}

commit-mass-and-fuel-draft() {
  copy-rsc RocketFuelPart0/src
  in-src remove-lines-in-file Fuel.kt 10 15
  in-src remove-lines-in-file Fuel.kt 3 4

  in-src replace-in-file Mass.kt "inKg: Double" "amount: Int"
  in-src replace-in-file Fuel.kt "inKg: Double" "amount: Int"
  in-src replace-in-file Fuel.kt "inKg >= 0" "amount >= 0"

  git-commit "Add mass and fuel types"
}

commit-conflicting-changes-on-main() {
  #  git-checkout-main

  in-src replace-in-file Mass.kt "amount" "inKg"
  in-src replace-in-file Fuel.kt "amount" "inKg"

  git-commit "Fix mass and fuel terminology"
}

work-on-estimation() {
  git-checkout-feature "$1"

  in-src replace-in-file Mass.kt ": Int" ": Double"
  in-src replace-in-file Fuel.kt ": Int" ": Double"

  git-commit "Amend mass and fuel value to be double"

  copy-rsc RocketFuelPart0/src
  copy-rsc RocketFuelPart0/test

  in-src replace-in-file Mass.kt "inKg" "amount"
  in-src replace-in-file Fuel.kt "inKg" "amount"

  git-commit "Estimate fuel based on mass"
}
