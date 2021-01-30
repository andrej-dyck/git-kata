source ../scripts/#kata-scripts.sh
source ../104-local-rebase-onto-main/init-functions.sh

init-exercise() {
  cloned-exercise-repo

  local feature="fuel-estimation"
  work-on-feature-branch "$feature"
  git-push-feature-branch "$feature"

  readme-pushed-to-origin-main

  git-checkout-feature "$feature"
}

readme-pushed-to-origin-main() {
  git-checkout-main
  commit-rocket-fuel-readme
  git-push-changes
  git reset --hard HEAD~1
}