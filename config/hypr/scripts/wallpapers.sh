#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Imágenes/walls/"
CURRENT_WALL_FILE="$WALLPAPER_DIR/current_wallpaper"

while true; do
    # Obtener lista de imágenes excluyendo el archivo current_wallpaper
    WALLPAPERS=$(find "$WALLPAPER_DIR" -type f -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" | grep -v "$CURRENT_WALL_FILE")
    
    # Elegir un wallpaper aleatorio
    NEW_WALLPAPER=$(echo "$WALLPAPERS" | shuf -n 1)
    
    if [[ -n "$NEW_WALLPAPER" && -f "$NEW_WALLPAPER" ]]; then
        # Copiar el nuevo wallpaper como current_wallpaper
        cp "$NEW_WALLPAPER" "$CURRENT_WALL_FILE"
        
        # Recargar hyprpaper con el nuevo wallpaper
        hyprctl hyprpaper unload all
        hyprctl hyprpaper preload "$CURRENT_WALL_FILE"
        hyprctl hyprpaper wallpaper ",$CURRENT_WALL_FILE"
        
        echo "Wallpaper cambiado a: $(basename "$NEW_WALLPAPER")"
    else
        echo "No se encontraron wallpapers disponibles en: $WALLPAPER_DIR"
    fi
    
    # Espera antes de cambiar otra vez (5 minutos = 300s)
    sleep 30
done
