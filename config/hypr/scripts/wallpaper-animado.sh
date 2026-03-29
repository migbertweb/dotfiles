#!/bin/bash
#
# wallpaper-animado.sh - Establece fondos de pantalla animados usando mpvpaper
# en un setup multi-monitor con Hyprland (Wayland).
#

# Directorio que contiene los videos para el fondo de pantalla
WALLPAPER="$HOME/Imágenes/wallpapers/videos/"

# Tiempo de espera (en segundos) antes de iniciar mpvpaper en cada monitor
TIME=480    # Monitor principal (eDP-1)
TIME2=600   # Monitor secundario (HDMI-A-2)

# Esperar 5 segundos para asegurar que el compositor Hyprland esté completamente iniciado
sleep 5

# Iniciar mpvpaper en el monitor principal (eDP-1)
# -n: Nombre de la instancia
# -o: Opciones de mpv:
#   - no-audio: Sin audio
#   - loop: Reproducir en bucle
#   - shuffle: Reproducción aleatoria
#   - loop-playlist=inf: Bucle infinito de la lista de reproducción
#   - directory-mode=recursive: Incluir subdirectorios
#   - hwdec=auto: Decodificación por hardware automática
#   - gpu-context=wayland: Contexto GPU para Wayland
#   - profile=low-latency: Perfil de baja latencia
#   - interpolation=no: Sin interpolación de frames
#   - scale/dscale/cscale=bilinear: Filtros de escalado bilineal
#   - no-config: No cargar configuración de mpv
#   - really-quiet: Modo silencioso
mpvpaper eDP-1 -n "$TIME" -o "no-audio loop shuffle loop-playlist=inf directory-mode=recursive hwdec=auto gpu-context=wayland profile=low-latency interpolation=no scale=bilinear dscale=bilinear cscale=bilinear no-config really-quiet" "$WALLPAPER" &

# Verificar si hay un monitor secundario conectado (HDMI-A-2)
if hyprctl monitors | grep -q "HDMI-A-2"; then
    # Iniciar mpvpaper en el monitor secundario con opciones simplificadas
    mpvpaper HDMI-A-2 -n "$TIME2" -o "no-audio loop shuffle loop-playlist=inf" "$WALLPAPER" &
fi