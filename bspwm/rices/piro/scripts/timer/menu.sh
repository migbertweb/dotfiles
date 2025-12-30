#!/bin/bash

BASE="$HOME/.config/bspwm/rices/piro/scripts/timer/"

PAUSED_FILE="$BASE/paused.txt"
MODE_FILE="$BASE/mode.txt"

current_mode=$(cat "$MODE_FILE")
paused=$(cat "$PAUSED_FILE")

echo "--- Menú de Temporizador ---"
echo "1) Cronómetro"
echo "2) Cuenta atrás"
if [[ "$current_mode" != "idle" ]]; then
	if [[ "$paused" == "1" ]]; then
		echo "3) Reanudar"
	else
		echo "3) Pausar"
	fi
	echo "4) Detener / Reset"
fi
echo "q) Salir"
read -r opt

case "$opt" in
1)
	echo "0" >"$BASE/countdown"
	echo "0" >"$PAUSED_FILE"
	notify-send "⏱️ Cronómetro" "Iniciado"
	echo "chrono" >"$MODE_FILE"
	;;
2)
	echo "Tiempo en segundos:"
	read -r t
	echo "$t" >"$BASE/countdown"
	echo "0" >"$PAUSED_FILE"
	notify-send "⏳ Temporizador" "Cuenta atrás de $t segundos iniciada"
	echo "countdown" >"$MODE_FILE"
	;;
3)
	if [[ "$paused" == "1" ]]; then
		echo "0" >"$PAUSED_FILE"
		notify-send "▶️ Temporizador" "Reanudado"
	else
		echo "1" >"$PAUSED_FILE"
		notify-send "⏸️ Temporizador" "Pausado"
	fi
	;;
4)
	echo "idle" >"$MODE_FILE"
	echo "0" >"$PAUSED_FILE"
	# Pequeño delay para dejar que timer.sh cambie de ciclo antes de borrar
	sleep 0.1
	rm -f "$BASE/countdown"
	echo "inactive" >"$BASE/state.txt"
	notify-send "⏹️ Temporizador" "Detenido y reseteado"
	;;
q)
	exit 0
	;;
*)
	exit 0
	;;
esac
