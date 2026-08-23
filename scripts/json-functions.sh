#!/usr/bin/env bash

json-edit() {
  if [ "$#" -lt 2 ]; then
    echo "Usage: json-edit <file> <jq-filter> [extra_args...]" >&2
    return 1
  fi

  local targetFile="$1"
  local filter="$2"
  shift 2

  if [ ! -f "$targetFile" ]; then
    echo "Error: File '$targetFile' not found." >&2
    return 1
  fi

  local tempFile
  tempFile="$(mktemp "${targetFile}.tmp.XXXXXX" 2>/dev/null || mktemp)"

  if jq-run "$@" "$filter" "$targetFile" > "$tempFile"; then
    mv -f "$tempFile" "$targetFile"
  else
    local exitCode=$?
    rm -f "$tempFile"
    echo "Error: Failed to process JSON filter on '$targetFile'." >&2
    return $exitCode
  fi
}

jq-run() {
  _find-jq-bin || return 1
  "$_JQ_BIN" "$@"
}

_JQ_BIN=""

_find-jq-bin() {
  if [ -n "$_JQ_BIN" ] && { command -v "$_JQ_BIN" >/dev/null 2>&1 || [ -x "$_JQ_BIN" ]; }; then
    return 0
  fi

  local detectedBin
  if detectedBin="$(_find-system-jq-bin)"; then
    _JQ_BIN="$detectedBin"
  elif detectedBin="$(_find-bundled-jq-bin)"; then
    _JQ_BIN="$detectedBin"
  else
    echo "Error: Neither 'jq' nor 'jaq' was found on PATH." >&2
    echo "Please install jq (https://jqlang.github.io/jq/) or jaq (https://github.com/01mf02/jaq)." >&2
    return 1
  fi

  return 0
}

_find-system-jq-bin() {
  if command -v jq >/dev/null 2>&1; then
    command -v jq
  elif command -v jaq >/dev/null 2>&1; then
    command -v jaq
  elif command -v jq.exe >/dev/null 2>&1; then
    command -v jq.exe
  elif command -v jaq.exe >/dev/null 2>&1; then
    command -v jaq.exe
  else
    return 1
  fi
}

_find-bundled-jq-bin() {
  local scriptDir binDir osName archName candidate=""
  scriptDir="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
  binDir="$scriptDir/bin"
  osName="$(_detect-os)"
  archName="$(_detect-arch)"

  if [ "$osName" = "windows" ]; then
    candidate="$binDir/jq-windows-${archName}.exe"
  elif [ -n "$osName" ] && [ -n "$archName" ]; then
    candidate="$binDir/jq-${osName}-${archName}"
  fi

  if [ -n "$candidate" ] && [ -f "$candidate" ]; then
    chmod +x "$candidate" 2>/dev/null || true
    echo "$candidate"
  else
    return 1
  fi
}

_detect-os() {
  local uname_s
  uname_s="$(uname -s 2>/dev/null || echo "")"
  case "$uname_s" in
    Linux*) echo "linux" ;;
    Darwin*) echo "macos" ;;
    CYGWIN*|MINGW*|MSYS*|*Windows*|*NT*) echo "windows" ;;
    "")
      case "$OSTYPE" in
        linux*) echo "linux" ;;
        darwin*) echo "macos" ;;
        msys*|cygwin*|win32*) echo "windows" ;;
        *) echo "" ;;
      esac
      ;;
    *) echo "" ;;
  esac
}

_detect-arch() {
  local uname_m
  uname_m="$(uname -m 2>/dev/null || echo "")"
  case "$uname_m" in
    x86_64|amd64|x64) echo "amd64" ;;
    aarch64|arm64|armv8*) echo "arm64" ;;
    "")
      if [ "${PROCESSOR_ARCHITECTURE:-}" = "ARM64" ]; then
        echo "arm64"
      elif [ "${PROCESSOR_ARCHITECTURE:-}" = "AMD64" ]; then
        echo "amd64"
      else
        echo ""
      fi
      ;;
    *) echo "" ;;
  esac
}
