#!/bin/bash

# Función para mostrar el título con estilo
show_title() {
  echo -e "\n$(tput bold)$(tput setaf 5)========== Brillo del Teclado ==========$(tput sgr0)\n"
}

# Función para obtener y mostrar el brillo actual
show_current_brightness() {
  local info
  info=$(brightnessctl --device='dell::kbd_backlight' info)
  local brightness
  brightness=$(echo "$info" | grep -oP "Current brightness: \d+ \(\K[0-9]+(?=%\))")
  echo -e "$(tput bold)$(tput setaf 6)El nivel de brillo del teclado actual es: $brightness%$(tput sgr0)"
}

# Función para mostrar el menú
show_menu() {
  echo -e "\n$(tput bold)$(tput setaf 3)Seleccione el nivel de brillo para el teclado retroiluminado:$(tput sgr0)"
  echo -e "  $(tput setaf 1)0$(tput sgr0): Apagado"
  echo -e "  $(tput setaf 2)1$(tput sgr0): 50%"
  echo -e "  $(tput setaf 4)2$(tput sgr0): 100%"
  echo -e "\n$(tput bold)$(tput setaf 6)Ingrese su opción (0, 1, 2):$(tput sgr0) "
}

# Mostrar título
clear
show_title

# Mostrar brillo actual
show_current_brightness

# Mostrar menú y capturar la selección del usuario
while true; do
  show_menu
  read -r option
  case $option in
  0)
    brightnessctl --device='dell::kbd_backlight' set 0%
    echo -e "$(tput setaf 1)El teclado retroiluminado está ahora apagado.$(tput sgr0)"
    break
    ;;
  1)
    brightnessctl --device='dell::kbd_backlight' set 50%
    echo -e "$(tput setaf 2)El teclado retroiluminado está ahora al 50%.$(tput sgr0)"
    break
    ;;
  2)
    brightnessctl --device='dell::kbd_backlight' set 100%
    echo -e "$(tput setaf 4)El teclado retroiluminado está ahora al 100%.$(tput sgr0)"
    break
    ;;
  *)
    echo -e "$(tput bold)$(tput setaf 1)Opción inválida. Por favor intente de nuevo.$(tput sgr0)"
    ;;
  esac
done

# Esperar 5 segundos antes de cerrar
echo -e "\n$(tput bold)$(tput setaf 2)El terminal se cerrará automáticamente en 3 segundos...$(tput sgr0)"
sleep 3

# Forzar el cierre de Kitty
kill -9 $PPID
