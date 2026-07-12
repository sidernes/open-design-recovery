# Actualización de upstream

El kit nunca sigue `main` automáticamente.

1. Crea una rama en este repositorio.
2. Cambia commit y versión en `upstream.lock`.
3. Reconstruye en un workspace vacío.
4. Ejecuta `scripts/verify.sh`.
5. Dentro de upstream ejecuta `pnpm guard` y `pnpm typecheck`.
6. Comprueba el arranque mediante `pnpm tools-dev`.
7. Confirma el cambio solo si overlays y parches siguen siendo compatibles.

Mantén el tag anterior para poder recuperar la última revisión probada.
