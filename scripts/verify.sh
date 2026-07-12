#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")" && pwd)/lib.sh"

require_command git
require_command node

expected_commit="$(lock_get commit)"
expected_version="$(lock_get version)"
[[ -d "$UPSTREAM_DIR/.git" ]] || die "ejecuta scripts/bootstrap.sh primero"
actual_commit="$(git -C "$UPSTREAM_DIR" rev-parse HEAD)"
[[ "$actual_commit" == "$expected_commit" ]] || die "commit incorrecto: $actual_commit"
actual_version="$(node -p "require('$UPSTREAM_DIR/package.json').version")"
[[ "$actual_version" == "$expected_version" ]] || die "versión incorrecta: $actual_version"
[[ "$(node -p 'process.versions.node.split(".")[0]')" == 24 ]] || die "se requiere Node 24"

while IFS= read -r path || [[ -n "$path" ]]; do
  [[ -z "$path" || "$path" == \#* ]] && continue
  cmp -s "$KIT_ROOT/overlays/$path" "$UPSTREAM_DIR/$path" || die "overlay ausente o diferente: $path"
done < "$KIT_ROOT/overlays/manifest"

git -C "$UPSTREAM_DIR" diff --check
printf 'Verificación correcta: Open Design %s @ %s\n' "$actual_version" "$actual_commit"
