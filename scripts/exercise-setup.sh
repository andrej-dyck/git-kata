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
  initScriptDir="$(cd "$(dirname "$callerScript")" && pwd)" || return

  local exerciseDir
  exerciseDir="$(_safe-exercise-dir "${1:-$REPO_ROOT_DIR/exercise}")" || return

  local exerciseName
  exerciseName="$(basename "$initScriptDir")"

  echo "▶ Initialize '$exerciseName'"

  echo "Ensure exercise folder exists and is empty"
  _ensure-empty-dir "${exerciseDir:?}" || return
  rm -rf -- "${exerciseDir:?}-origin"

  _start-spinner "⚒ Setting up the exercise"

  local initExitCode=0
  init-exercise "$initScriptDir" "$exerciseDir" || initExitCode=$?

  _stop-spinner

  if [ "$initExitCode" -ne 0 ]; then
    echo "❌ Failed to initialize '$exerciseName' at '$exerciseDir'" >&2
    return "$initExitCode"
  fi

  git-log-graph "🔀 Initialized Git history"

  echo "✅ Successfully initialized '$exerciseName'"
  echo " ∟ at 📁 '$exerciseDir'"
}

_safe-exercise-dir() {
  local exerciseDir="$1"

  local exerciseDirResolved
  exerciseDirResolved="$(realpath -m "$exerciseDir")" || return

  if [[ -z "$exerciseDirResolved" || "$exerciseDirResolved" == "/" ]]; then
    echo "🛑 Refusing to use unsafe exercise directory: '$exerciseDir'" >&2
    return 1
  fi

  if [[ "$exerciseDirResolved" != "$(realpath -m "$REPO_ROOT_DIR")/"* ]]; then
    echo "🛑 Refusing to use path outside this repository: '$exerciseDirResolved'" >&2
    return 1
  fi

  realpath -m "$exerciseDir"
}

_ensure-empty-dir() {
  local dir=$1

  if [[ ! -e $dir ]]; then
    mkdir -p -- "$dir"
    return
  fi

  if [[ ! -d $dir ]]; then
    echo "⚡ Failed to create directory '$dir'; file exists and is not a directory" >&2
    return 1
  fi

  if [[ -z $(find "$dir" -mindepth 1 -maxdepth 1 -print -quit) ]]; then
    return 0 # dir is already empty
  fi

  find "$dir" -mindepth 1 -maxdepth 1 -exec rm -rf -- {} +
}

_start-spinner() {
  local message="${1:-Working}"
  local delay="${2:-0.2}"
  local spinner='|/-\'

  (
    local i=0
    while true; do
      sleep "$delay"
      printf "\r%s %s" "$message" "${spinner:i++%${#spinner}:1}"
    done
  ) &

  SPINNER_PID=$!
}
SPINNER_PID=""

_stop-spinner() {
  if [[ -n "${SPINNER_PID:-}" ]]; then
    kill "$SPINNER_PID" 2>/dev/null || true
    wait "$SPINNER_PID" 2>/dev/null || true
    unset SPINNER_PID
  fi

  printf "\b✔\b\n"
}
