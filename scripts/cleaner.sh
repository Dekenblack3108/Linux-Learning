#!/bin/bash

#============================================================
#Limpiador de sistema con modo simulacion
#============================================================

# --- Configuracion ---
CARPETAS_TEMP=("/tmp" "$HOME/.cache")
DIAS_ANTIGUEDAD=7
DRY_RUN=false

# --- Leer argumentos ---
if [ "$1" == "--dry-run" ]; then
    DRY_RUN=true
    echo "MODO SIMULACION: no se va a borrar nada, solo se muestra que se haria."
fi

echo "=========================================================="
echo "     LIMPIADOR DE SISTEMA - $(date +"%Y-%m-%d %H:%M:%S")"
echo "==========================================================="

TOTAL_LIBERADO=0

for CARPETA in "${CARPETAS_TEMP[@]}"; do

    if [ ! -d "$CARPETA" ]; then
        echo "Carpeta no encontrada, se omite: $CARPETA"
        continue
    fi

    echo ""
    echo "--- Revisando: $CARPETA ---"

    #Buscar archivos con mas de X dias de antiguedad
    ARCHIVOS=$(find "$CARPETA" -type f -mtime +"$DIAS_ANTIGUEDAD" 2>/dev/null)

    if [ -z "$ARCHIVOs" ]; then
        echo "No hay archivos viejos para limpiar aquí."
        continue
    fi

    # Contar cuantos archivos y cuanto espacio ocupan.

    CANTIDAD=$(echo "$ARCHIVOs" | wc -l)
    TAMANO=$(du -ch $ARCHIVOS 2>/dev/null | tail -1 | cut -f1)

    echo "Archivos encontrados: $CANTIDAD (ocupan aprox. $TAMANO)"

    if [ "$DRY_RUN" = true ]; then
        echo "Se borrarian estos archivos (simulacion):"
        echo "$ARCHIVOS"
    else
        echo "Borrando archivos..."
        echo "$ARCHIVOS" | xargs rm -f
        echo "Archivos eliminados."
    fi

done

echo ""
echo "======================================"
echo "Limpieza finalizada."
echo "======================================"
        
