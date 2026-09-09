#!/usr/bin/env bash

git-commit() {
  if [ "$#" -lt 1 ]; then
    echo "Usage: git-commit <commit-message> [files...]" >&2
    return 1
  fi

  local commitMsg="$1" files="${2:-}"

  _git-stage-files "$files"
  git commit -q -m "$commitMsg"
}

git-amend-commit() {
  local commitMsg="${1:-}" files="${2:-}"

  _git-stage-files "$files"

  if [ -z "$commitMsg" ]; then
    git commit -q --amend --no-edit
  else
    git commit -q --amend -m "$commitMsg"
  fi
}

_git-stage-files() {
  local pattern="${1:-}"

  if [ -z "$pattern" ]; then
    git add --all
  else
    git add -- "$pattern"
  fi
}

git-new-branch() {
  git switch -c "$1"
}

git-switch-branch() {
  git switch "$1"
}

git-switch-main() {
  git switch "main"
}

git-push-new-branch() {
  git push -q -u origin "$1"
}

git-push() {
  git push -q origin
}

git-log-graph() {
  if [ "$#" -ge 1 ]; then
    echo "$1"
  fi

  git log --all --graph --pretty=format:'%C(auto)%h%Creset%C(auto)%d%Creset %s %C(green)(%cr)%Creset %C(blue)<%an>%Creset' --abbrev-commit --date=relative
  echo
}
