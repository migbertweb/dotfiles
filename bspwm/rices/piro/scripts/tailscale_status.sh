#!/bin/bash

# Verifica si el comando tailscale existe
if ! command -v tailscale &>/dev/null; then
	echo "error: tailscale no está instalado"
	exit 1
fi

# Check if Tailscale is active
is_tailscale_active() {
	tailscale status --active 2>/dev/null | grep -q "migbertweb"
}

# Get current status
get_tailscale_status() {
	if is_tailscale_active; then
		echo "on"
	else
		echo "off"
	fi
}

# Toggle Tailscale connection
toggle_tailscale() {
	if is_tailscale_active; then
		if tailscale down 2>/dev/null; then
			notify-send -u normal "Tailscale Desconectado" "Interfaz de Tailscale desactivada"
		else
			notify-send -u critical "Error de Tailscale" "Error al desconectar"
		fi
	else
		if tailscale up 2>/dev/null; then
			notify-send -u normal "Tailscale Conectado" "Interfaz de Tailscale activada"
		else
			notify-send -u critical "Error de Tailscale" "Error al conectar"
		fi
	fi
}

case "$1" in
--toggle)
	toggle_tailscale
	;;
*)
	get_tailscale_status
	;;
esac
