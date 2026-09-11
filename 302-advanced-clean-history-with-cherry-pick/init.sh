#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
source "$REPO_ROOT_DIR/301-advanced-interactive-rebase-onto-a-rewritten-branch/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo-with-origin "$exerciseDir" "$thisDir/README.md" || return

  echo ""
  echo ""
  echo "🚧 Exercise under Construction"
  echo ""
  return 2

  # TODO setup git history for exercise
}

run-init-exercise "$@"
