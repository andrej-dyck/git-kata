#!/usr/bin/env bash
set -euo pipefail

# expects `init.sh` to define function `init-exercise`
# and runs it when `init.sh` is called directly (rather than imported)
run-init-exercise() {
  local callerScript="${BASH_SOURCE[1]}"

  if [[ "$callerScript" != "$0" ]]; then
    return 0 # ignore call when init.sh is imported
  fi

  local initScriptDir
  initScriptDir="$(cd "$(dirname "$callerScript")" && pwd)"
  readonly initScriptDir

  local exerciseName
  exerciseName="$(basename "$initScriptDir")"
  readonly exerciseName

  local exerciseDir
  exerciseDir="${1:-$REPO_ROOT_DIR/exercise}"
  readonly exerciseDir

  echo "Initialize '$exerciseName' at '$exerciseDir'"

  echo "Ensure exercise folder is empty"
  rm -rf "${exerciseDir:?}" && mkdir "$exerciseDir"

  init-exercise "$exerciseDir"

  echo "Successfully initialized '$exerciseName' at '$exerciseDir'"
}
