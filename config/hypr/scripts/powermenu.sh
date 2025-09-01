#!/usr/bin/env bash

options="  Bloquear sesión
󰤄  Suspender
  Reiniciar
  Apagar
󰍃  Cerrar sesión"

# ruta a tu estilo personalizado
STYLE="$HOME/.config/hypr/wofi/powermenu.css"

chosen=$(echo -e "$options" | wofi --dmenu -W 280 -H 30 -j -w 1 -s "$STYLE")

case "$chosen" in
    "  Bloquear sesión") loginctl lock-session ;;
    "󰤄  Suspender") systemctl suspend ;;
    "  Reiniciar") systemctl reboot ;;
    "  Apagar") systemctl poweroff ;;
    "󰍃  Cerrar sesión") hyprctl dispatch exit ;;
esac
