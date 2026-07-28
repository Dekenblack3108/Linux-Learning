#!/bin/bash

echo "======================================================"
echo "  MONITOR DE RECURSOS - $(date +"%Y-%m-%d %H:%M:%S")"
echo "======================================================"

echo ""
echo "--- USO DE CPU ---"
top -bn1 | grep "Cpu(s)" | awk '{print "CPU en uso: " $2 "%"}'

echo ""
echo "--- MEMORIA RAM ---"
free -h | awk '/^Mem:/ {print "Total: " $2 " | Usada: " $3 " | Libre: " $4}'

echo ""
echo "--- USO DE DISCO ---"
df -h / | awk 'NR==2 {print "Total: " $2 " | Usado: " $3 " (" $5 ") | Disponible: " $4}'

echo ""
echo "--- TOP 5 PROCESOS (CPU) ---"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu| head -n 6

echo ""
echo "--- TOP 5 PROCESOS (RAM) ---"
ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6

echo ""
echo "========================================================"
echo "REPORTE FINALIZADO"
echo "========================================================"