#!/bin/bash

# =======================================================================
# Gestor de usuarios desde archivo CSV
# =======================================================================

CSV="usuarios/usuarios.csv"

# --- Verificar que el script corre con sudo ---
if [ "$EUID" -ne 0 ]; then
    echo "Este script necesita permisos de administrador."
    echo "Ejecutalo con: sudo ./gestor_usuarios.sh"
    exit 1
fi

# --- Verificar que el CSV existe ---
if [ ! -f "$CSV" ]; then
    echo "Error: no se encontro el archivo $CSV"
    exit 1
fi

echo "=========================================================="
echo "              GESTOR DE USUARIOS"
echo "=========================================================="

PRIMERA_LINEA=true

while IFS=, read -r usuario nombre grupo; do

    # --- Saltar la linea de encabezado ---
    if [ "$PRIMERA_LINEA" = true ]; then
        PRIMERA_LINEA=false
        continue
    fi

    echo ""
    echo "--- Procesando: $usuario ---"

    # --- Verificar si el usuario ya existe ---
    if id "$usuario" &>/dev/null; then
        echo "El usuario '$usuario' ya existe, se omite."
        continue
    fi
    
    # --- Crear el grupo si no existe ---
    if ! getent group "$grupo" &>/dev/null; then
        groupadd "$grupo"
        echo "Grupo creado: $grupo"
    fi

    # --- Crear el usuario ---
    useradd -m -c "$nombre" -g "$grupo" "$usuario"

    if [ $? -eq 0 ]; then
        echo "Usuario creado: $usuario (grupo: $grupo, nombre: $nombre)"
    else   
        echo "Errir al crear el usuario: $usuario"
    fi

done < "$CSV"

echo ""
echo "======================================"
echo "Proceso finalizado."
echo "======================================"
