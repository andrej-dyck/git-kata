source ../scripts/#kata-scripts.sh
source ../104-local-rebase-onto-main/init-functions.sh

init-exercise() {
  clean-exercise-repo

  local feature="fuel-estimation"

  git-feature-branch "$feature"

  commit-rocket-fuel-readme

  copy-rsc RocketFuelPart0/src
  in-src remove-lines-in-file Fuel.kt 10 15
  in-src remove-lines-in-file Fuel.kt 3 4
  git-commit "drafting types"

  commit-first-estimate-formula-draft

  copy-to-src RocketFuelPart0/src/Fuel.kt
  copy-rsc RocketFuelPart0/test
  git-commit "squash! estimate"
}

commit-first-estimate-formula-draft() {
  copy-to-src RocketFuelPart0/src/Fuel.kt
  in-src replace-in-file Fuel.kt "maxOf(" ""
  in-src replace-in-file Fuel.kt ", 0.0)" ""
  git-commit "estimate formula"
}

