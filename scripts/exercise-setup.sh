#!/usr/bin/env bash

# this function is expected to be called by an exercise `init.sh`
# expects `init.sh` to define function `init-exercise`
# and runs it when `init.sh` is called directly (rather than imported)
run-init-exercise() {
  local callerScript="${BASH_SOURCE[1]}"

  if [[ "$callerScript" != "$0" ]]; then
    return 0 # ignore call when init.sh is imported
  fi

  local initScriptDir
  initScriptDir="$(cd "$(dirname "$callerScript")" && pwd)"

  local exerciseDir
  exerciseDir="${1:-$REPO_ROOT_DIR/exercise}"

  local exerciseName
  exerciseName="$(basename "$initScriptDir")"

  echo "Initialize '$exerciseName' at '$exerciseDir'"

  echo "Ensure exercise folder exists and is empty"
  rm -rf "${exerciseDir:?}" && mkdir "$exerciseDir"
  rm -rf "${exerciseDir:?}-origin"

  local initExitCode=0
  init-exercise "$initScriptDir" "$exerciseDir" || initExitCode=$?

  if [ "$initExitCode" -ne 0 ]; then
    echo "Failed to initialize '$exerciseName' at '$exerciseDir'" >&2
    return "$initExitCode"
  fi

  git-log-graph "Initialized Git history"
  echo "Successfully initialized '$exerciseName' at '$exerciseDir'"
}
