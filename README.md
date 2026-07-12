# Open Design Recovery Kit

Respaldo liviano y reproducible de una instalación de [Open Design](https://github.com/nexu-io/open-design). Este repositorio **no duplica el código ni el historial upstream**: fija una revisión pública, conserva configuración saneada y automatiza su reconstrucción.

## Restauración rápida

Requisitos: Git, Node.js 24, Corepack y acceso a GitHub.

```bash
git clone <URL-DE-ESTE-REPOSITORIO>
cd open-design-recovery
./scripts/bootstrap.sh
./scripts/verify.sh
cd workspace/open-design
pnpm tools-dev
```

La reconstrucción usa Open Design `0.8.1`, commit `3f4fd58937538cd0588432abef5a24baf488a9e7`, con `pnpm@10.33.2`.

## Contenido

- `upstream.lock`: origen y revisión exacta.
- `overlays/`: archivos locales públicos que se agregan al checkout.
- `patches/`: cambios propios ordenados en `series`.
- `config/`: ejemplos sin credenciales.
- `docs/`: configuración, operación, respaldo privado y actualizaciones.
- `scripts/`: reconstrucción y verificación.

## Lo que nunca se publica aquí

`workspace/`, `node_modules`, `.tmp`, `.od`, SQLite, memorias, proyectos generados, claves API, tokens, cookies, logs y builds. Consulta [docs/PRIVATE-BACKUP.md](docs/PRIVATE-BACKUP.md) para conservar datos operativos por separado.

## Origen y licencia

Open Design pertenece a sus autores y se distribuye bajo Apache-2.0. Este kit contiene solamente automatización y documentación propia; al reconstruir se descarga el código desde el repositorio oficial.
