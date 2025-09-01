#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Imágenes/walls/"

while true; do
    CURRENT_WALL=$(hyprctl hyprpaper listloaded)

    # Elegir aleatorio distinto al actual
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

    # Cargar nuevo fondo
    hyprctl hyprpaper unload all
    hyprctl hyprpaper preload "$WALLPAPER"
    hyprctl hyprpaper wallpaper ",$WALLPAPER"   # cambia "eDP-1" por tu monitor real

    # Espera antes de cambiar otra vez (ej: 5 minutos = 300s)
    sleep 300
done
