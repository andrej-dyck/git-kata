#!/usr/bin/env bash

git-commit() {
  if [ "$#" -lt 1 ]; then
    echo "Usage: git-commit <commit-message> [files...]" >&2
    return 1
  fi

  local commitMsg="$1" files="${2:-}"

  _git-stage-files "$files"
  git commit -q -m "$commitMsg" || return $?
}

git-amend-commit() { # obsolete? TODO remove
  local commitMsg="$1" files="${2:-}"

  _git-stage-files "$files"
  git commit -q --amend -m "$commitMsg" || return $?
}

_git-stage-files() {
  local pattern="${1:-}"

  if [ -z "$pattern" ]; then
    git add --all || return $?
  else
    git add "$pattern" || return $?
  fi
}

git-checkout-new-branch() {
  git checkout -b "$1" || return $?
}

git-checkout-branch() {
  git checkout "$1" || return $?
}

git-checkout-main() {
  git checkout "main" || return $?
}

git-push-new-branch() {
  git push -q -u origin "$1" || return $?
}

git-push() {
  git push -q origin || return $?
}

git-push-changes() { # obsolete(use git-push) TODO remove
  git-push || return $?
}

git-feature-branch() { # obsolete? TODO remove
  git-checkout-new-branch "feature/$1" || return $?
}

git-push-feature-branch() { # obsolete? TODO remove
  git-push-new-branch "feature/$1" || return $?
}

git-checkout-feature() { # obsolete? TODO remove
  git-checkout-branch "feature/$1" || return $?
}

git-log-graph() {
  if [ "$#" -ge 1 ]; then
    echo "$1"
  fi

  git log --all --graph --pretty=format:'%C(auto)%h%Creset%C(auto)%d%Creset %s %C(green)(%cr)%Creset %C(blue)<%an>%Creset' --abbrev-commit --date=relative
}
