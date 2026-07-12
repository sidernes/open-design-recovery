# Respaldo privado opcional

El repositorio público reconstruye el software, pero no conserva proyectos, conversaciones ni credenciales.

Antes de respaldar datos, detén Open Design con `pnpm tools-dev stop`. Conserva la carpeta `.od/` completa en almacenamiento privado cifrado para mantener juntos `app.sqlite`, WAL/SHM si existieran, proyectos, artefactos y configuración. No la subas a GitHub, ni siquiera a un commit que luego pretendas borrar: Git conservaría el objeto en el historial.

La configuración actual contiene al menos una clave de conector y las memorias pueden incluir información personal. Verifica una restauración del archivo cifrado en un directorio temporal antes de eliminar el original.
