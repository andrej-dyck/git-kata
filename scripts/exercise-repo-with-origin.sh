#!/usr/bin/env bash

init-exercise-repo-with-origin() {
  if [ "$#" -lt 2 ]; then
    echo "Usage: init-exercise-repo-with-origin <exercise-dir> <exercise-readme-path>" >&2
    return 1
  fi

  local exerciseDir="$1" exerciseReadmePath="$2"
  local originDir="$exerciseDir-origin"

  # create a bare origin repo
  _init-bare-origin "$originDir" || return $?

  # clone exercise repo
  _create-or-clone-new-exercise-repo "$exerciseDir" "$originDir" || return $?

  # push initial commits
  _initial-commits "$exerciseReadmePath" || return $?
  git push || return $?

  cd "$exerciseDir" || return $?
}

_init-bare-origin() {
  local originDir="$1"

  # make main the default branch for init
  git config --global init.defaultBranch main || return $?

  # cleanup existing exercise folder
  rm -rf "${originDir:?}" || return $?
  mkdir -p "$originDir" || return $?

  # create a bare remote
  git init --bare "$originDir" || return $?
}
