#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")" && pwd)/lib.sh"

[[ -d "$UPSTREAM_DIR/.git" ]] || die "no existe el checkout upstream"

while IFS= read -r path || [[ -n "$path" ]]; do
  [[ -z "$path" || "$path" == \#* ]] && continue
  [[ "$path" != /* && "$path" != *../* && "$path" != ../* ]] || die "ruta de overlay insegura: $path"
  [[ -f "$KIT_ROOT/overlays/$path" ]] || die "overlay inexistente: $path"
  mkdir -p "$(dirname "$UPSTREAM_DIR/$path")"
  cp "$KIT_ROOT/overlays/$path" "$UPSTREAM_DIR/$path"
done < "$KIT_ROOT/overlays/manifest"
