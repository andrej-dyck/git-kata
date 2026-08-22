#!/usr/bin/env bash

git-commit() {
  if [ "$#" -lt 1 ]; then
    echo "Usage: git-commit <commit-message> [files...]" >&2
    return 1
  fi

  local commitMsg="$1" files="${2:-}"

  _git-stage-files "$files"
  git commit -m "$commitMsg" || return $?
}

git-amend-commit() {
  local commitMsg="$1" files="${2:-}"

  _git-stage-files "$files"
  git commit --amend -m "$commitMsg" || return $?
}

_git-stage-files() {
  local pattern="${1:-}"

  if [ -z "$pattern" ]; then
    git add --all || return $?
  else
    git add "$pattern" || return $?
  fi
}

git-feature-branch() {
  local name="$1"

  git checkout -b "feature/$name" || return $?
}

git-push-changes() {
  git push origin || return $?
}

git-push-feature-branch() {
  local name="$1"

  git push -u origin "feature/$name" || return $?
}

git-checkout-main() {
  git checkout "main" || return $?
}

git-checkout-feature() {
  local name="$1"

  git checkout "feature/$name" || return $?
}
