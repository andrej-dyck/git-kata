init-exercise-repo-with-origin() {
  local readmePath="${PWD##*/}"

  local originDir="../exercise-origin"

  # we need a bare origin
  init-bare-origin "$originDir"

  # clone exercise repo
  create-or-clone-new-exercise-repo "$originDir"

  # push initial commits
  initial-commits "../$readmePath" # we are in exercise-dir now
  git push
}

init-bare-origin() {
  local originDir="$1"

  # make main the default branch for init
  git config --global init.defaultBranch main

  # cleanup existing exercise folder
  rm -rf "${originDir:?}"
  mkdir -p "$originDir"

  # create a bare remote
  git init --bare "$originDir"
}
