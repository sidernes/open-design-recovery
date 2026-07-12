#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")" && pwd)/lib.sh"

[[ -d "$UPSTREAM_DIR/.git" ]] || die "no existe el checkout upstream"

while IFS= read -r patch || [[ -n "$patch" ]]; do
  [[ -z "$patch" || "$patch" == \#* ]] && continue
  [[ "$patch" != /* && "$patch" != *../* && "$patch" != ../* ]] || die "ruta de parche insegura: $patch"
  file="$KIT_ROOT/patches/$patch"
  [[ -f "$file" ]] || die "parche inexistente: $patch"
  git -C "$UPSTREAM_DIR" apply --check "$file"
  git -C "$UPSTREAM_DIR" apply "$file"
done < "$KIT_ROOT/patches/series"
