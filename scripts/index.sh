#!/usr/bin/env bash

REPO_ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"

source "$REPO_ROOT_DIR/scripts/exercise-repo.sh"
source "$REPO_ROOT_DIR/scripts/exercise-repo-with-origin.sh"
source "$REPO_ROOT_DIR/scripts/exercise-setup.sh"
source "$REPO_ROOT_DIR/scripts/git-functions.sh"

source "$REPO_ROOT_DIR/scripts/obsolete-functions.sh" # TODO remove
