#!/bin/bash

# Archivo de configuración
CONFIG_FILE="$HOME/.config/adjust_brightness.conf"

# Variables para evitar notificaciones repetidas
LAST_BRIGHTNESS=""
LAST_POWER_STATE=""
LAST_INACTIVE_STATE=""
BATTERY_FULL_NOTIFIED=false

# Configurar notificaciones
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus

# Función para cargar configuración
load_config() {
  if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
  else
    echo "Archivo de configuración no encontrado. Iniciando GUI para configurarlo..."
    bash configure_brightness_gui.sh
    if [[ -f "$CONFIG_FILE" ]]; then
      source "$CONFIG_FILE"
    else
      echo "Error: no se pudo crear el archivo de configuración. Saliendo."
      exit 1
    fi
  fi
}

# Cargar la configuración al inicio
load_config

# Función para ajustar brillo según alimentación
adjust_brightness() {
  local power_state=$(acpi -a | grep -q "on-line" && echo "AC" || echo "BATTERY")
  local new_brightness

  # Notificación al cambiar el estado de alimentación
  if [[ "$power_state" != "$LAST_POWER_STATE" ]]; then
    if [[ "$power_state" == "AC" ]]; then
      notify-send -i "battery-full-charging" "Cargador conectado" "La laptop está conectada a la corriente."
    else
      notify-send -i "battery-empty" "Cargador desconectado" "La laptop está funcionando con batería."
    fi
  fi

  # Ajustar brillo según el estado de alimentación
  if [[ "$power_state" == "AC" ]]; then
    new_brightness="$BRIGHTNESS_ON_AC"
  else
    new_brightness="$BRIGHTNESS_ON_BATTERY"
  fi

  # Cambiar el brillo solo si es necesario
  if [[ "$new_brightness" != "$LAST_BRIGHTNESS" || "$power_state" != "$LAST_POWER_STATE" ]]; then
    brightnessctl set "${new_brightness}%"
    # notificacion de cambio de brillo
    #notify-send "Brillo ajustado" "Nivel de brillo: ${new_brightness}% ($power_state)."
    LAST_BRIGHTNESS="$new_brightness"
    LAST_POWER_STATE="$power_state"
  fi
}
# Función para manejar niveles de batería
check_battery() {
  local capacity=$(cat /sys/class/power_supply/BAT0/capacity)
  local status=$(cat /sys/class/power_supply/BAT0/status)

  # Notificar batería completa (una sola vez)
  if [[ "$capacity" -eq 100 && "$status" == "Charging" && "$BATTERY_FULL_NOTIFIED" == false ]]; then
    notify-send -i "battery-full" "Batería cargada" "La batería está al 100%. Por favor desconecta el cargador."
    BATTERY_FULL_NOTIFIED=true
  elif [[ "$capacity" -lt 100 ]]; then
    BATTERY_FULL_NOTIFIED=false
  fi

  # Acciones para batería baja o crítica
  if [[ "$capacity" -le "$CRITICAL_BATTERY_THRESHOLD" && "$status" == "Discharging" ]]; then
    notify-send -u critical -i "battery-caution" "Batería crítica" "Nivel de batería: ${capacity}%. Apagando servicios para ahorrar energía."
    rfkill block bluetooth                             # Apagar Bluetooth
    rfkill block wifi                                  # Apagar Wi-Fi
    brightnessctl --device='dell::kbd_backlight' set 0 # Apagar luz del teclado
  elif [[ "$capacity" -le "$LOW_BATTERY_THRESHOLD" && "$status" == "Discharging" ]]; then
    notify-send -u normal -i "battery-low" "Batería baja" "Nivel de batería: ${capacity}%."
  fi
}

# Función para monitorear inactividad y ajustar brillo
monitor_inactivity() {
  local idle_time=$(xprintidle)
  local inactive_brightness
  local current_inactive_state

  # Determinar estado de inactividad
  if [[ $(cat /sys/class/power_supply/AC/online) == "1" ]]; then
    if [[ "$idle_time" -ge "$AC_IDLE_TIME" ]]; then
      inactive_brightness="$BRIGHTNESS_ON_AC_IDLE"
      current_inactive_state="INACTIVE"
    else
      current_inactive_state="ACTIVE"
    fi
  else
    if [[ "$idle_time" -ge "$BATTERY_IDLE_TIME" ]]; then
      inactive_brightness="$BRIGHTNESS_ON_BATTERY_IDLE"
      current_inactive_state="INACTIVE"
    else
      current_inactive_state="ACTIVE"
    fi
  fi

  # Ajustar brillo si cambia el estado de inactividad
  if [[ "$current_inactive_state" == "INACTIVE" && "$current_inactive_state" != "$LAST_INACTIVE_STATE" ]]; then
    brightnessctl set "${inactive_brightness}%"
    LAST_BRIGHTNESS="$inactive_brightness"
    LAST_INACTIVE_STATE="$current_inactive_state"
  elif [[ "$current_inactive_state" == "ACTIVE" && "$current_inactive_state" != "$LAST_INACTIVE_STATE" ]]; then
    # Volver al brillo normal según el estado de alimentación
    adjust_brightness
    LAST_INACTIVE_STATE="$current_inactive_state"
  fi

}

# Función para bloquear y suspender el sistema
lock_and_suspend() {
  idle_time=$(xprintidle) # Obtiene el tiempo de inactividad en milisegundos

  if [[ $idle_time -ge $SUSPEND_TIME ]]; then
    notify-send "Inactividad detectada" "El sistema se bloqueará y suspenderá en breve."
    sleep 5 # Espera de 10 segundos para que el usuario vea la notificación

    # Suspender el sistema
    systemctl suspend

    # Bloquear la sesión (puedes personalizar el comando según tu sistema)
    ScreenLocker --rice

  fi
}

# Bucle principal
while true; do
  adjust_brightness
  check_battery
  monitor_inactivity
  lock_and_suspend # Llama a la función para verificar inactividad
  sleep 5
done
