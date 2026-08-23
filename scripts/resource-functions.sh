#!/usr/bin/env bash

read-rsc() {
  if [ "$#" -lt 1 ]; then
    echo "Usage: read-rsc <resource-path>" >&2
    return 1
  fi

  cat "$REPO_ROOT_DIR/resources/$1"
}

copy-rsc() {
  if [ "$#" -lt 1 ]; then
    echo "Usage: read-rsc <resource-rel-path> <exercise-rel-path>" >&2
    return 1
  fi

  local resourceRelPath="$1" exerciseRelPath="$2"

  local targetDir
  targetDir="$(dirname "$exerciseRelPath")"

  if [ -n "$targetDir" ] && [ ! -d "$targetDir" ]; then
    mkdir -p "$targetDir"
  fi

  cp -rf "$REPO_ROOT_DIR/resources/$resourceRelPath" "$exerciseRelPath"
}
