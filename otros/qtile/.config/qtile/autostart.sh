#!/bin/sh

# systray battery icon
# cbatticon -u 5 &
# systray volume
volumeicon &
# network manager
nm-applet &
# gestor de Dispositivos
udiskie -t &
# slideshow wallpapers
$HOME/.config/qtile/slideshow.sh &
# compositor
picom &
# Music server
mpd &
# Playertctl support for mpd
# mpDris2 &
