#!/usr/bin/env bash

init-exercise-repo-with-origin() {
  local readmePath="${PWD##*/}"

  local originDir="../exercise-origin" # TODO get as argument

  # we need a bare origin
  _init-bare-origin "$originDir"

  # clone exercise repo
  _create-or-clone-new-exercise-repo "$originDir"

  # push initial commits
  _initial-commits "../$readmePath" # we are in exercise-dir now
  git push
}

_init-bare-origin() {
  local originDir="$1"

  # make main the default branch for init
  git config --global init.defaultBranch main

  # cleanup existing exercise folder
  rm -rf "${originDir:?}"
  mkdir -p "$originDir"

  # create a bare remote
  git init --bare "$originDir"
}
