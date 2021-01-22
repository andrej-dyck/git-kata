clean-exercise-repo() {
  local readmePath="${PWD##*/}"

  # init repo without origin
  init-exercise-repo ""

  # make initial commits
  initial-commits "../$readmePath" # we are in exercise-dir now
}

init-exercise-repo() {
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

  # rename master branch if local repository
  if [ -z "$origin" ]; then
    rename-master-branch
  fi

  # configure simple gitflow
  git config --local gitflow.branch.develop "main"
  git config --local gitflow.prefix.feature "feature"
}

rename-master-branch() {
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
  git-commit "Add .gitignore" .gitignore

  cp "${readmePath}/Readme.md" .
  git-commit "Add exercise readme" Readme.md
}
