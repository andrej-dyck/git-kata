#!/bin/bash
source ../scripts/index.sh
source ../101-local-amend-commit/init.sh

init-exercise() {
  init-exercise-repo

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

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  init-exercise
fi
