#!/usr/bin/env bash

init-exercise-repo() {
  if [ "$#" -lt 2 ]; then
    echo "Usage: init-exercise-repo <exercise-dir> <exercise-readme-path>" >&2
    return 1
  fi

  local exerciseDir="$1" exerciseReadmePath="$2"

  # local repo without origin
  _init-new-git-repo "$exerciseDir" || return

  _initial-exercise-commits "$exerciseReadmePath" || return

  cd "$exerciseDir" || return
}

_initial-exercise-commits() {
  local exerciseReadmePath="$1"

  cd "$exerciseDir" || return

  cp "$REPO_ROOT_DIR/.gitignore" . || return
  echo "* text eol=lf encoding=utf-8" > .gitattributes || return
  git-commit "configure Git" .gitignore || return

  cp "$exerciseReadmePath" . || return
  git-commit "write README" README.md || return
}

_init-new-git-repo() {
  local dir="$1" origin="${2:-}"

  # make main the default branch for init
  git config --global init.defaultBranch main || return

  # initialize a new repository
  git init "$dir" || return

  # go to repo folder
  cd "$dir" || return

  # add origin if given
  if [ -n "$origin" ]; then
    git remote add origin "$origin" || return
  fi

  # local git config
  git config --local commit.gpgsign false
  git config --local core.autocrlf false

  # configure simple gitflow
  git config --local gitflow.branch.develop "main"
  git config --local gitflow.prefix.feature "feature"
}
