#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")" && pwd)/lib.sh"

require_command git
require_command node
require_command corepack

url="$(lock_get url)"
commit="$(lock_get commit)"

node_major="$(node -p 'process.versions.node.split(".")[0]')"
[[ "$node_major" == 24 ]] || die "Open Design requiere Node 24; versión actual: $(node --version)"

if [[ -e "$UPSTREAM_DIR" ]]; then
  [[ -d "$UPSTREAM_DIR/.git" ]] || die "el destino existe y no es un repositorio: $UPSTREAM_DIR"
  current="$(git -C "$UPSTREAM_DIR" rev-parse HEAD)"
  [[ "$current" == "$commit" ]] || die "el workspace existente usa otro commit: $current"
else
  mkdir -p "$WORKSPACE_ROOT"
  git init -q "$UPSTREAM_DIR"
  git -C "$UPSTREAM_DIR" remote add origin "$url"
  # Fetch one complete snapshot. Avoid a blobless checkout: repositories with
  # thousands of assets can otherwise trigger a long deferred-object fetch.
  git -C "$UPSTREAM_DIR" fetch --depth 1 origin "$commit"
  git -C "$UPSTREAM_DIR" checkout -q --detach "$commit"
fi

"$KIT_ROOT/scripts/apply-overlays.sh"
"$KIT_ROOT/scripts/apply-patches.sh"

package_manager="$(node -p "require('$UPSTREAM_DIR/package.json').packageManager")"
[[ "$package_manager" == pnpm@* ]] || die "packageManager upstream inesperado: $package_manager"
export COREPACK_HOME="${COREPACK_HOME:-$KIT_ROOT/.corepack}"
corepack prepare "$package_manager" --activate
corepack pnpm --dir "$UPSTREAM_DIR" install --frozen-lockfile
printf 'Reconstrucción lista en %s\n' "$UPSTREAM_DIR"
