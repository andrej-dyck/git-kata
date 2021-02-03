source ../scripts/#kata-scripts.sh
source ../104-local-rebase-onto-main/init-functions.sh

init-exercise() {
  cloned-exercise-repo

  # dev1 rebases feature branch onto main as in exercise 203
  commit-rocket-fuel-readme
  git-push-changes

  local feature="fuel-estimation"
  work-on-feature-branch "$feature"
  git-push-feature-branch "$feature"

  # dev2 has locally the old state
  git-checkout-main
  git branch -d "feature/$feature"
  git reset --hard HEAD~1

  work-on-feature-branch "$feature"
  git branch --set-upstream-to="origin/feature/$feature"
}

readme-pushed-to-origin-main() {
  git-checkout-main
  commit-rocket-fuel-readme
  git-push-changes
  git reset --hard HEAD~1
}