#!/usr/bin/env bash
set -euo pipefail

KIT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOCK_FILE="$KIT_ROOT/upstream.lock"
WORKSPACE_ROOT="${OD_RECOVERY_WORKSPACE:-$KIT_ROOT/workspace}"
UPSTREAM_DIR="$WORKSPACE_ROOT/open-design"

lock_get() {
  git config --file "$LOCK_FILE" --get "upstream.$1"
}

die() {
  printf 'error: %s\n' "$*" >&2
  exit 1
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || die "falta el comando requerido: $1"
}
