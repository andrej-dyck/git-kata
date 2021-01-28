git-stage-files() {
  local pattern="$1"

  if [ -z "$pattern" ]; then
    git add "."
  else
    git add "$pattern"
  fi
}

git-commit() {
  local commitMsg="$1" files="$2"

  git-stage-files "$files"
  git commit -m "$commitMsg"
}

git-amend-commit() {
  local commitMsg="$1" files="$2"

  git-stage-files "$files"
  git commit --amend -m "$commitMsg"
}