#!/usr/bin/env bash

init-exercise-repo() {
  if [ "$#" -lt 2 ]; then
    echo "Usage: init-exercise-repo <exercise-dir> <exercise-readme-path>" >&2
    return 1
  fi

  local exerciseDir="$1" exerciseReadmePath="$2"

  # local repo without origin
  _create-or-clone-new-exercise-repo "$exerciseDir" || return $?

  _initial-commits "$exerciseReadmePath" || return $?

  cd "$exerciseDir" || return $?
}

_initial-commits() {
  local exerciseReadmePath="$1"

  cd "$exerciseDir" || return $?

  cp "$REPO_ROOT_DIR/.gitignore" . || return $?
  git-commit "configure Git" .gitignore || return $?

  cp "$exerciseReadmePath" . || return $?
  git-commit "write exercise README" README.md || return $?
}

_create-or-clone-new-exercise-repo() {
  local exerciseDir="$1" origin="${2:-}"

  # make main the default branch for init
  git config --global init.defaultBranch main || return $?

  if [ -z "$origin" ]; then
    # initialize a new repository
    git init "$exerciseDir" || return $?
  else
    # otherwise clone origin
    git clone "$origin" "$exerciseDir" || return $?
  fi

  # go to exercise dir
  cd "$exerciseDir" || return $?

  # local git config
  git config --local commit.gpgsign false
  git config --local core.autocrlf false

  # configure simple gitflow
  git config --local gitflow.branch.develop "main"
  git config --local gitflow.prefix.feature "feature"
}
