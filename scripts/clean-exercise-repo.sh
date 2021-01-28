clean-exercise-repo() {
  local initScriptDir="${PWD##*/}"
  local exerciseDir="../exercise"

  # cleanup existing exercise repository
  rm -rf "${exerciseDir:?}"
  mkdir -p "$exerciseDir"

  # go there
  cd "$exerciseDir" || exit

  # initialize a new repository
  git init

  # local git config
  git config --local commit.gpgsign false
  git config --local core.autocrlf false

  # make initial commits
  initial-commits "$initScriptDir"

  # rename master to main
  # see https://tools.ietf.org/id/draft-knodel-terminology-00.html#rfc.section.1.1.1
  # for your global config: git config --global init.defaultBranch main
  local branchName=$(git branch --show-current)
  if [ "$branchName" = "master" ]; then
    git branch -m master main
  fi
}

initial-commits() {
  local initScriptDir="$1"

  cp ../.gitignore .
  git-commit "Add .gitignore" .gitignore

  if [ -z "$toLine" ]; then
    cp "../${initScriptDir}/Readme.md" .
    git-commit "Add exercise readme" Readme.md
  fi
}