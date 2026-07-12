# Configuración

## Entorno fijado

- Node.js: rama 24 (`~24` según upstream).
- pnpm: `10.33.2`, seleccionado mediante Corepack.
- Inicio: exclusivamente `pnpm tools-dev` dentro de `workspace/open-design`.

El `.nvmrc` público contiene `24`. No se guarda ninguna configuración global de la máquina.

## Configuración local

Los archivos de `config/` son plantillas, no copias de `.od`. Crea los archivos reales manualmente y mantenlos fuera de Git. `composio-config.example.json` contiene un marcador; jamás reemplaces ese marcador dentro del repositorio.

La precedencia de datos upstream es `OD_MEDIA_CONFIG_DIR`, después `OD_DATA_DIR` y finalmente `workspace/open-design/.od`.
