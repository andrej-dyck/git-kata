source ../scripts/#kata-scripts.sh
source ../101-local-amend-commit/init-functions.sh

init-exercise() {
  clean-exercise-repo

  commit-greeting-with-mistakes
  fix-greeting-mistakes
  extract-main
}

fix-greeting-mistakes() {
  copy-to-src Greeting.kt
}

extract-main() {
  in-src extract-lines-to-new-file Greeting.kt 6 8 main.kt
  in-src remove-lines-in-file Greeting.kt 5 8
}
