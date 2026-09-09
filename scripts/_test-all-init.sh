#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)" || exit $?

REPETITIONS="${1:-1}"

usage() {
  echo "Usage: $0 [number-of-repetitions]" >&2
  exit 3
}

[[ "$REPETITIONS" =~ ^[1-9][0-9]*$ ]] || usage

TEST_INIT="$REPO_ROOT_DIR/scripts/_test-init.sh"

[[ -x "$TEST_INIT" ]] || {
  echo "⚡ Expected executable test script at '$TEST_INIT'" >&2
  echo " ∟ Use: chmod +x scripts/_test-init.sh" >&2
  exit 2
}

EXERCISE_DIRS=()
while IFS= read -r exercisePath; do
  EXERCISE_DIRS+=("${exercisePath##*/}")
done < <(
  find "$REPO_ROOT_DIR" \
    -mindepth 1 \
    -maxdepth 1 \
    -type d \
    -name '[0-9][0-9][0-9]-*' \
    -exec test -f '{}/init.sh' ';' \
    -print |
  sort
)

[[ ${#EXERCISE_DIRS[@]} -gt 0 ]] || {
  echo "⚡ No exercise folders matching '<NNN>-<exercise>' with 'init.sh' found" >&2
  exit 2
}

echo "▶ Testing 'init.sh' files of ${#EXERCISE_DIRS[@]} exercises"
echo

for exerciseDir in "${EXERCISE_DIRS[@]}"; do
  "$TEST_INIT" "$exerciseDir" "$REPETITIONS"
  echo
done

echo "✅ PASS all exercise 'init.sh' files"
