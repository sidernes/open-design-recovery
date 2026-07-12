# Operación

Todos los comandos siguientes se ejecutan dentro de `workspace/open-design`.

```bash
pnpm tools-dev
pnpm tools-dev status --json
pnpm tools-dev logs --json
pnpm tools-dev check
pnpm tools-dev stop
```

No uses procesos improvisados ni agregues aliases raíz como `pnpm dev` o `pnpm start`. Los puertos y namespaces pertenecen a `tools-dev`.

Los datos locales viven por defecto en `.od/`. La carpeta `.tmp/` contiene ejecución temporal y puede regenerarse.
