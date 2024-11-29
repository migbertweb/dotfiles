#!/bin/bash

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RESET='\033[0m'

# Archivo de configuración
CONFIG_FILE="$HOME/.config/adjust_brightness.conf"

echo -e "${GREEN}============================================================================="
echo -e " Configurando los valores iniciales para el control de brillo y batería.  "
echo -e "=============================================================================${RESET}"
# echo -e "Por favor, ingrese los valores requeridos."

# Función para solicitar un valor numérico con validación
get_input() {
  local prompt="$1"
  local default="$2"
  local value

  while true; do
    read -p "$(echo -e "${CYAN}$prompt${RESET} [${YELLOW}$default${RESET}]: ")" value
    # read -p "$prompt [$default]: " value
    value="${value:-$default}"

    if [[ "$value" =~ ^[0-9]+$ ]]; then
      echo "$value"
      return
    else
      echo -e "${RED}Por favor, ingrese un número válido.${RESET}"
    fi
  done
}

# Función para convertir segundos a milisegundos
convert_to_milliseconds() {
  local seconds="$1"
  echo $((seconds * 1000))
}

echo
echo -e "${CYAN}Niveles de brillo (en porcentaje):${RESET}"
# Solicitar valores al usuario
BRIGHTNESS_ON_AC=$(get_input "Brillo con AC conectado (%)" "100")
BRIGHTNESS_ON_BATTERY=$(get_input "Brillo con batería (%)" "80")
BRIGHTNESS_ON_AC_IDLE=$(get_input "Brillo con AC en inactividad (%)" "40")
BRIGHTNESS_ON_BATTERY_IDLE=$(get_input "Brillo con batería en inactividad (%)" "30")

echo
echo -e "${CYAN}Tiempos de inactividad (en segundos):${RESET}"
# Solicitar tiempos en segundos y convertir a milisegundos
AC_IDLE_TIME_SECONDS=$(get_input "Tiempo de inactividad con AC (segundos)" "720") # 12 minutos
AC_IDLE_TIME=$(convert_to_milliseconds "$AC_IDLE_TIME_SECONDS")
BATTERY_IDLE_TIME_SECONDS=$(get_input "Tiempo de inactividad con batería (segundos)" "480") # 8 minutos
BATTERY_IDLE_TIME=$(convert_to_milliseconds "$BATTERY_IDLE_TIME_SECONDS")

echo
echo -e "${CYAN}Niveles críticos de batería (en porcentaje):${RESET}"
LOW_BATTERY_THRESHOLD=$(get_input "Nivel de batería baja (%)" "30")
CRITICAL_BATTERY_THRESHOLD=$(get_input "Nivel de batería crítica (%)" "20")

echo
echo -e "${CYAN}Tiempo para suspender el sistema (en segundos):${RESET}"
SUSPEND_TIME_SECONDS=$(get_input "Tiempo para suspender" "600")
SUSPEND_TIME=$(convert_to_milliseconds "$SUSPEND_TIME_SECONDS")

# Guardar configuración
echo
echo -e "${CYAN}Guardando configuración en $CONFIG_FILE...${RESET}"
# Crear el archivo de configuración
cat >"$CONFIG_FILE" <<EOL
# Configuración de brillo y energía

BRIGHTNESS_ON_AC=$BRIGHTNESS_ON_AC
BRIGHTNESS_ON_BATTERY=$BRIGHTNESS_ON_BATTERY
BRIGHTNESS_ON_AC_IDLE=$BRIGHTNESS_ON_AC_IDLE
BRIGHTNESS_ON_BATTERY_IDLE=$BRIGHTNESS_ON_BATTERY_IDLE
AC_IDLE_TIME=$AC_IDLE_TIME
BATTERY_IDLE_TIME=$BATTERY_IDLE_TIME
LOW_BATTERY_THRESHOLD=$LOW_BATTERY_THRESHOLD
CRITICAL_BATTERY_THRESHOLD=$CRITICAL_BATTERY_THRESHOLD
SUSPEND_TIME=$SUSPEND_TIME
EOL

# Resumen
echo
echo -e "${GREEN}========================================="
echo -e "         Resumen de Configuración         "
echo -e "=========================================${RESET}"
echo -e "${YELLOW}Tiempos de inactividad:${RESET}"
echo -e "  - Con AC: ${CYAN}${AC_IDLE_TIME}s${RESET}"
echo -e "  - Con batería: ${CYAN}${BATTERY_IDLE_TIME}s${RESET}"

echo -e "${YELLOW}Niveles de brillo:${RESET}"
echo -e "  - Con AC: ${CYAN}${BRIGHTNESS_ON_AC}%${RESET}"
echo -e "  - Con batería: ${CYAN}${BRIGHTNESS_ON_BATTERY}%${RESET}"
echo -e "  - En inactividad con AC: ${CYAN}${BRIGHTNESS_ON_AC_IDLE}%${RESET}"
echo -e "  - En inactividad con Batería: ${CYAN}${BRIGHTNESS_ON_BATTERY_IDLE}%${RESET}"

echo -e "${YELLOW}Niveles críticos:${RESET}"
echo -e "  - Batería baja: ${CYAN}${LOW_BATTERY_THRESHOLD}%${RESET}"
echo -e "  - Batería crítica: ${CYAN}${CRITICAL_BATTERY_THRESHOLD}%${RESET}"

echo -e "${YELLOW}Suspensión automática:${RESET}"
echo -e "  - Tiempo para suspender: ${CYAN}${SUSPEND_TIME}s${RESET}"
echo
# Confirmación final
echo -e "${CYAN}============================================="
echo -e "         Configuración completada.           "
echo -e "=============================================${RESET}"
echo -e "${GREEN}¡Configuración guardada exitosamente!${RESET}"
echo -e "${GREEN}El archivo se guardó en: $CONFIG_FILE${RESET}"
echo -e "${RED}=========================================${RESET}"
echo
# Tarea de suspensión en segundo plano
# echo -e "${CYAN}Iniciando monitoreo para suspensión automática...${RESET}"
#
# (
#   sleep "$SUSPEND_TIME"
#   systemctl suspend
# ) &
echo
