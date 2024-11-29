#!/bin/bash

# Configuración
CIUDAD="Joinville" # Cambia a tu ciudad
IDIOMA="es"        # Idioma (es, en, etc.)
FORMATO="m"        # "m" para Celsius, "u" para Fahrenheit

# Opciones para wttr.in
OPCIONES="?&lang=${IDIOMA}&${FORMATO}"

# Verifica si curl está instalado
if ! command -v curl &>/dev/null; then
  echo "Error: curl no está instalado. Por favor, instálalo e intenta nuevamente."
  exit 1
fi

# Obtiene el clima usando wttr.in
echo "Obteniendo el clima para $CIUDAD (en ${IDIOMA}, formato ${FORMATO})..."
CLIMA=$(curl -s "https://wttr.in/${CIUDAD}${OPCIONES}")

# Muestra el resultado
if [ -z "$CLIMA" ]; then
  echo "Error: No se pudo obtener el clima. Verifica tu conexión a Internet."
else
  echo "El clima en $CIUDAD: $CLIMA"
fi
# Pausa para que la ventana no se cierre
echo "Presiona cualquier tecla para salir..."
read -n 1 -s
