# This file launch the bar/s
for i in /sys/class/hwmon/hwmon*/temp1_input; do
	if [ "$(<$(dirname $i)/name)" = "coretemp" ]; then
		export HWMON_PATH="$i"
		break
	fi
done

for mon in $(polybar --list-monitors | cut -d":" -f1); do
	MONITOR=$mon polybar -q emi-bar -c "${HOME}"/.config/bspwm/rices/"${RICE}"/config.ini &
done
