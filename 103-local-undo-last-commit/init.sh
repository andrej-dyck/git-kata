#!/bin/bash
source ../scripts/index.sh
source ../102-local-commit-changes/init.sh

init-exercise() {
  clean-exercise-repo

  commit-greeting-main-draft "Draft main"
  commit-unfinished-greeting "WIP: greeting"
}

commit-greeting-main-draft() {
  local msg="$1"

  copy-to-src Greeting.kt
  extract-main

  in-src git-commit "$msg" main.kt
}

commit-unfinished-greeting() {
  local msg="$1"

  in-src replace-in-file Greeting.kt ") = \"Hello, \$name!\"" ") = TODO()"

  git-commit "$msg"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  init-exercise
fi
