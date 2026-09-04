#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)" || exit $?

EXERCISE_DIR_ARG="${1%"${1##*[!/\\]}"}"
[[ -n "$EXERCISE_DIR_ARG" ]] || usage

REPETITIONS=${2:-1}
[[ $REPETITIONS =~ ^[1-9][0-9]*$ ]] || usage

usage() {
  echo "Usage: $0 <NNN-exercise-name> [number-of-repetitions]" >&2
  exit 3
}

exit-unexpectingly() {
  echo "⚡ Unexpectingly failed during test of '$EXERCISE_DIR_ARG': $1" >&2
  exit 2
}

fail-check() {
  echo "❌ FAIL '$EXERCISE_DIR_ARG': $1" >&2
  shift
  while [[ $# -ge 1 ]]; do
    echo " ∟ $1"
    shift
  done
  exit 1
}

pass() {
  echo "✅ PASS '$EXERCISE_DIR_ARG'"
  return 0
}

test-init-script() {
  local exerciseName=$1 testCycle=$2
  local initScriptDir="$REPO_ROOT_DIR/$exerciseName"

  [[ -d "$initScriptDir" ]] || fail-check "No exercise folder '$initScriptDir' found"
  [[ -f "$initScriptDir/init.sh" || -x "$initScriptDir/init.sh" ]] || fail-check "No executable 'init.sh' found in '$initScriptDir'"
  cd "$initScriptDir" || exit-unexpectingly "Could not navigate to folder: $initScriptDir"

  local exerciseNumber="$(basename "$exerciseName" | sed -E 's/^([0-9]+)-.+/\1/')"
  [[ "$exerciseNumber" =~ ^[0-9]+$ ]] || fail-check "No exercise number determined" "Expected '$exerciseName' to follow '<NNN>-<name>'"

  if [[ $REPETITIONS -ge 2 ]]; then
    echo "▶ Testing 'init.sh' of '$exerciseName' (🔁 $testCycle/$REPETITIONS)"
  else
    echo "▶ Testing 'init.sh' of '$exerciseName'"
  fi

  # Temporary files
  initScriptOutput="$(mktemp)" || exit-unexpectingly "Failed to create temporary file"
  exerciseTempDir=$(mktemp -d "$REPO_ROOT_DIR/exercise-XXXXXX") || exit-unexpectingly "Failed to create temporary exercise folder"
  trap 'cleanup "$initScriptOutput"; cleanup "$exerciseTempDir"' EXIT RETURN

  # Test git-index of 'init.sh' for execution flag
  check-init-script-file-mode "$initScriptDir" || exit-unexpectingly "Failed to check chmod=+x"

  # Test for successful 'init.sh' execution
  run-init-script "$initScriptDir" "$exerciseTempDir" "$initScriptOutput" || exit-unexpectingly "Failed to run 'init.sh'"

  # Test for generated exercise folder
  [[ -d "$exerciseTempDir" ]] || fail-check "No exercise folder '$exerciseTempDir' found" "Expected 'init.sh' to generate the folder '$exerciseTempDir'"
  cd "$exerciseTempDir" || exit-unexpectingly "Could not navigate to folder: $exerciseTempDir"

  # Test exercise README
  check-readme "$exerciseNumber" "$exerciseTempDir" || exit-unexpectingly "Failed to check README.md"

  # Test Git log against README
  check-git-log || exit-unexpectingly "Failed to check Git log"

  # No Fail -> Pass
  pass
}

check-init-script-file-mode() {
  local initScriptDir="$1"

  local lsOutput
  lsOutput=$(git ls-files -s "$initScriptDir/init.sh")

  # checks for execution flag chmod +x
  [[ "$lsOutput" =~ ^100755\ .+ ]] || fail-check "Expected execution flag (+x '100755') for 'init.sh'" "Git ls-files was: $lsOutput" "Use 'git update-index --chmod=+x init.sh' to make 'init.sh' executable"
}

run-init-script() {
  local initScriptDir="$1" exerciseDir="$2" initOutput="$3"

  echo '----------------------------------------'
  (
    './init.sh' "$exerciseDir" || exit-unexpectingly "Failed to run 'init.sh'"
  ) 2>&1 | tee "$initOutput"

  local lastOutputLine="$(tail -n 1 "$initOutput")"
  echo '----------------------------------------'

  [[ "$lastOutputLine" =~ ^Successfully\ initialized\ .+ ]] || fail-check "Expected last console output line to be 'Successfully initialized ...'" "Last console output line was: $lastOutputLine"
}

check-readme() {
  local exerciseNumber="$1" exerciseDir="$2"

  [[ -f README.md ]] || fail-check "No 'README.md' found in '$exerciseDir'"

  local firstLine="$(head -n 1 README.md)"
  [[ "$firstLine" =~ ^#\ ${exerciseNumber}([^0-9]|$) ]] || fail-check "Expected 'README.md' to start with '# $exerciseNumber'" "First line of 'README.md' was: $firstLine"
}

check-git-log() {
  actualHistoryNormalized="$(
    git log --oneline --graph --decorate --all |
      sed -E 's/[0-9a-f]{7,40}/<hash>/g; s/[[:blank:]]*$//'
  )"

  readmeHistoryNormalized="$(
    awk '
      /^### Initial Git History[[:space:]]*$/ { in_section = 1; next }
      in_section && /^```/ {
        fence_count++
        next
      }
      in_section && fence_count == 1 {
        if ($0 !~ /^\$ git log --oneline --graph --decorate --all[[:space:]]*$/) {
          print
        }
      }
      in_section && fence_count == 2 {
        exit
      }
    ' README.md |
      sed -E 's/[0-9a-f]{7,40}/<hash>/g; s/[[:blank:]]*$//'
  )"

  [[ -n "$readmeHistoryNormalized" ]] || fail-check "Could not extract 'Initial Git History' from 'README.md'"

  if [[ "$actualHistoryNormalized" != "$readmeHistoryNormalized" ]]; then
    echo "❗ README's 'Initial Git History' and actual Git log differ" >&2
    diff -u \
      --label "README's 'Initial Git History'" \
      --label "Actual Git log" \
      <(printf '%s\n' "$readmeHistoryNormalized") \
      <(printf '%s\n' "$actualHistoryNormalized") || true

    fail-check "Expected Git log to match README's 'Initial Git History'"
  fi
}

cleanup() {
  [[ -f "$1" || -d "$1" ]] || return 0

  echo "🧹 Cleanup: '$1'"

  local resolvedPath
  resolvedPath="$(realpath -m "$1")" || return

  if [[ -z "$resolvedPath" || "$resolvedPath" == "/" ]]; then
    echo "Refusing to remove unsafe exercise directory: '$exerciseDir'" >&2
    return 1
  fi

  if [[ "$resolvedPath" != "$(realpath -m "$REPO_ROOT_DIR")/"* && "$resolvedPath" != "/tmp/"* ]]; then
    echo "Refusing to remove path outside this repository: '$resolvedPath'" >&2
    return 1
  fi

  rm -rf -- "${1:?}"
}

for ((i = 1; i <= $REPETITIONS; i++)); do
  if [[ $i -ge 2 ]]; then echo; fi
  test-init-script $EXERCISE_DIR_ARG $i
done
