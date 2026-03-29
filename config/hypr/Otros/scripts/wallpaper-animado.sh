#!/bin/bash

WALLPAPER="$HOME/Imágenes/wallpapers/videos/"
TIME=300

sleep 5
mpvpaper eDP-1 -n "$TIME" -o "no-audio loop shuffle loop-playlist=inf directory-mode=recursive hwdec=auto gpu-context=wayland profile=low-latency interpolation=no scale=bilinear dscale=bilinear cscale=bilinear no-config really-quiet" $WALLPAPER