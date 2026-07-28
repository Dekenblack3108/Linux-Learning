#!/bin/bash

#=======================================================
# Script de backup con rotacion de antiguos
#=======================================================

#---Configuracion---

ORIGEN="/home/kevin_solano/Linux-Learning/proyectos"           #Carpeta que se va a respaldar
DESTINO="/home/kevin_solano/Linux-Learning/backups"            #Carpeta donde se va a guardar los backups
DIAS_RETENCION=7                                #Dias que se conservan los backups

#--- Preparar variables---
FECHA=$(date +"%Y-%m-%d_%H-%M-%S")
NOMBRE_BACKUP="backup_${FECHA}.tar.gz"

#---Verificar que la carpeta origen existe---
if [ ! -d "$ORIGEN" ]; then
    echo "Error: la carpeta de origen no existe: $ORIGEN"
    exit 1
fi

#---Crear carpeta destino si no existe---
mkdir -p "$DESTINO"

#---Crear el backup comprimido---
echo "Creando backup de $ORIGEN..."
tar -czf "$DESTINO/$NOMBRE_BACKUP" -C "$(dirname "$ORIGEN")" "$(basename "$ORIGEN")"

if [ $? -eq 0 ]; then
    echo "Backup creado: $DESTINO/$NOMBRE_BACKUP"
else
    echo "Error al crear el backup"
    exit 1
fi

#---Borrar bacups mas viejos que DIAS_RETENCION---
echo "Eliminando backups con mas de $DIAS_RETENCION dias..."
find "$DESTINO" -name "backup_*.tar.gz" -type f -mtime +"$DIAS_RETENCION" -exec rm -v {} \;

echo "proceso completado."
