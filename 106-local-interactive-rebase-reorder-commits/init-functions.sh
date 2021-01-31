source ../scripts/#kata-scripts.sh
source ../104-local-rebase-onto-main/init-functions.sh

init-exercise() {
  clean-exercise-repo

  local feature="fuel-estimation"

  git-feature-branch "$feature"

  commit-mass-and-fuel-types
  commit-rocket-fuel-readme
  commit-fuel-estimation
}
