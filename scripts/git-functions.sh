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

git-feature-branch() {
  local name="$1"

  git checkout -b "feature/$name"
}

git-push-feature-branch() {
  local name="$1"

  git push -u origin "feature/$name"
}

git-checkout-main() {
  git checkout "main"
}

git-checkout-feature() {
  local name="$1"

  git checkout "feature/$name"
}
