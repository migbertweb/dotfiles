#!/bin/bash

while true; do
  for f in $HOME/Imagenes/wallpapers/*; do
    feh -z --bg-scale --no-fehbg "$f"
    sleep 600
  done
done
 
#feh \
#    --recursive \
#    --randomize \
#    --fullscreen \
#    --quiet \
#    --hide-pointer \
#    --bg-scale \
#    --slideshow-delay 2 \
#   $HOME/Imagenes/wallpapers/ 
