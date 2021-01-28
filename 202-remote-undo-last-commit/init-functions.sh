source ../scripts/#kata-scripts.sh
source ../103-local-undo-last-commit/init-functions.sh

init-exercise() {
  cloned-exercise-repo

  local feature="add-greeting"

  git-feature-branch "$feature"

  commit-greeting-main-draft "Draft main"
  amend-commit-with-working-main "Draft main"

  commit-unfinished-greeting "WIP: greeting"
  amend-commit-with-correct-main "WIP: greeting"

  git-push-feature-branch "$feature"
}

amend-commit-with-working-main() {
  in-src replace-in-file main.kt "Greeting.sayHello()" "Hello!"

  in-src git-amend-commit "$1" main.kt
}

amend-commit-with-correct-main() {
  in-src replace-in-file main.kt "Hello!" "Greeting.sayHello()"

  git-amend-commit "$1"
}