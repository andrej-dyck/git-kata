source ../scripts/#kata-scripts.sh

init-exercise() {
  clean-exercise-repo

  commit-greeting-with-mistakes
}

commit-greeting-with-mistakes() {
  copy-to-src Greeting.kt

  in-src replace-in-file Greeting.kt "String = \"Git\"" "String = \"World\""
  in-src prepend-line-to-file Greeting.kt "import java.io.OutputStream\n"

  in-src git-commit "Add greeting"
}
