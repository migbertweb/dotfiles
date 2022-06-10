#!/bin/sh

# systray battery icon
# cbatticon -u 5 &
# systray volume
volumeicon &
# network manager
nm-applet &

udiskie -t &
feh --bg-scale /home/migbert/.config/qtile/wallpapers/wallpaperuse.com-programacion-wallpaper-246642.jpg
# compositor
picom &
