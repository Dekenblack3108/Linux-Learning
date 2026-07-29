# Linux-Learning

Proyectos de práctica y aprendizaje en Linux y Shell Scripting.

## Proyectos

### backup.sh

Script Bash que comprime una carpeta utilizando `tar`, crea un backup con la fecha en el nombre y elimina automáticamente los backups con más de 7 días de antigüedad.

#### Uso

Dar permisos de ejecución al script:

```bash
chmod +x scripts/backup.sh
```
### monitor.sh 

Script Bash utilizado para monitorear información básica del sistema Linux.

```bash
chmod +x scripts/monitor.sh
./scripts/monitor.sh
```
### cleaner.sh
Busca y elimina archivos con más de 7 días de antigüedad en `/tmp` y `~/.cache`.
Incluye modo simulación para revisar qué se borraría sin eliminar nada.

**Uso:**
```bash
./scripts/cleaner.sh --dry-run   # solo muestra que se borraria
./scripts/cleaner.sh             # borra de verdad
```

