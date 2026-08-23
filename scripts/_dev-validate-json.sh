#!/usr/bin/env bash
set -euo

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/json-functions.sh"

jq-run "." "$1"
