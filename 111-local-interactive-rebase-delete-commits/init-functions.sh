source ../scripts/#kata-scripts.sh
source ../104-local-rebase-onto-main/init-functions.sh
source ../107-local-interactive-rebase-squash-commits/init-functions.sh
source ../110-local-interactive-rebase-split-commits/init-functions.sh

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
  git-commit "REMOVE tmp main for drafting"
}