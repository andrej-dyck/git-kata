init-exercise-repo() {
  local readmePath="${PWD##*/}"

  # init repo without origin
  create-or-clone-new-exercise-repo ""

  # make initial commits
  initial-commits "../$readmePath" # we are in exercise-dir now
}

create-or-clone-new-exercise-repo() {
  local origin="$1"

  local exerciseDir="../exercise"

  # cleanup existing exercise folder
  rm -rf "${exerciseDir:?}"

  if [ -z "$origin" ]; then
    # initialize a new repository
    git init $exerciseDir
  else
    # otherwise clone origin
    git clone "$origin" "$exerciseDir"
  fi

  # go to exercise dir
  cd "$exerciseDir" || exit

  # local git config
  git config --local commit.gpgsign false
  git config --local core.autocrlf false

  # ensure main branch is called main not master if it's a non-cloned-repo
  if [ -z "$origin" ]; then
    ensure-main-branch-naming
  fi

  # configure simple gitflow
  git config --local gitflow.branch.develop "main"
  git config --local gitflow.prefix.feature "feature"
}

ensure-main-branch-naming() {
  # rename master to main
  # cf. https://sfconservancy.org/news/2020/jun/23/gitbranchname/
  # for your global config: "git config --global init.defaultBranch main"
  local branchName=$(git branch --show-current)
  if [ "$branchName" = "master" ]; then
    git branch -m master main
  fi
}

initial-commits() {
  local readmePath="$1"

  cp ../.gitignore .
  git-commit "configure .gitignore" .gitignore

  cp "${readmePath}/README.md" .
  git-commit "add exercise README" README.md
}
