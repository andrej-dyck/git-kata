source ../scripts/#kata-scripts.sh
source ../104-local-rebase-onto-main/init-functions.sh
source ../110-local-interactive-rebase-split-commits/init-functions.sh

init-exercise() {
  cloned-exercise-repo

  push-fuel-estimation-without-min-req
  git-push-changes


  local feature="min-required-fuel-estimation"

  git-feature-branch "$feature"
  commit-test-arguments-prep
  git-push-feature-branch "$feature"

  # commit on wrong branch
  git-checkout-main
  commit-fuel-min-requirement-wo-test-args
}

push-fuel-estimation-without-min-req() {
  commit-rocket-fuel-readme
  commit-mass-and-fuel-types-in-one-commit
  commit-fuel-estimation
}

commit-test-arguments-prep() {
  copy-to-test RocketFuelPart1/test/TestArguments.kt

  git-commit "Extend test arguments with string to int-array"
}

commit-fuel-min-requirement-wo-test-args() {
  copy-to-src RocketFuelPart1/src/Mass.kt
  copy-to-src RocketFuelPart1/src/RocketFuelEstimate.kt
  copy-to-test RocketFuelPart1/test/MinRequiredFuelTest.kt

  git-commit "woops, wrong branch! Estimate min fuel requirement"
}