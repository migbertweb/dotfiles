#!/bin/bash

BASE="$HOME/.config/bspwm/rices/piro/scripts/timer/"
STATE="$BASE/state.txt"
MODE="$BASE/mode.txt"
PAUSED="$BASE/paused.txt"
COUNTDOWN="$BASE/countdown"

seconds=0
# lista de modos
# chrono
# countdown
# idle
while true; do
	mode=$(cat "$MODE")
	paused=$(cat "$PAUSED")

	if [[ "$paused" == "1" && "$mode" != "idle" ]]; then
		sleep 0.5
		continue
	fi

	case "$mode" in
	chrono)
		if [[ ! -f "$COUNTDOWN" ]]; then
			echo "0" >"$COUNTDOWN"
			seconds=0
		else
			seconds=$(cat "$COUNTDOWN")
		fi

		printf "%02d:%02d\n" $((seconds / 60)) $((seconds % 60)) >"$STATE"
		echo $((seconds + 1)) >"$COUNTDOWN"
		sleep 1
		;;

	countdown)
		[[ ! -f "$COUNTDOWN" ]] && echo "idle" >"$MODE" && continue

		seconds=$(cat "$COUNTDOWN")

		if ((seconds <= 0)); then
			echo "%{F#888888}00:00%{F-}" >"$STATE"
			notify-send "⏰ Temporizador" "Cuenta atrás finalizada"
			paplay /usr/share/sounds/freedesktop/stereo/complete.oga &
			echo "idle" >"$MODE"
			rm -f "$COUNTDOWN"
		else
			if ((seconds <= 10)); then
				color="#ff5555"
			elif ((seconds <= 60)); then
				color="#f1fa8c"
			else
				color="#50fa7b"
			fi

			printf "%%{F%s}%02d:%02d%%{F-}\n" \
				"$color" $((seconds / 60)) $((seconds % 60)) >"$STATE"

			echo $((seconds - 1)) >"$COUNTDOWN"
		fi
		sleep 1
		;;

	idle)
		echo "00:00" >"$STATE"
		rm -f "$COUNTDOWN"
		sleep 1
		;;

	*)
		sleep 0.5
		;;
	esac
done
