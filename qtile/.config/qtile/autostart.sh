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
# Inicio del SSH-Agent
 if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi
