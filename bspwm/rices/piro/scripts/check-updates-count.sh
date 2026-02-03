#!/usr/bin/env bash

# File for polybar module 'updates' to read
CACHE_FILE="$HOME/.cache/Updates.txt"

# Ensure only one instance runs
if pgrep -x -f "$(readlink -f "$0")" | grep -v $$ >/dev/null; then
	exit 0
fi

while true; do
	# Detect system and get update count
	if command -v checkupdates &>/dev/null; then
		updates=$(checkupdates 2>/dev/null | wc -l)
	elif command -v apt &>/dev/null; then
		updates=$(apt list --upgradable 2>/dev/null | grep -c upgradable)
	else
		updates=0
	fi

	# Output the count (useful for manual execution or debugging)
	echo "$updates"

	# Update the cache file for the 'updates' module hook
	echo "$updates" >"$CACHE_FILE"

	# Notify polybar modules
	if [ "$updates" -gt 0 ]; then
		# Show module and refresh hook if there are updates
		polybar-msg action "#myupdates.module_show" >/dev/null 2>&1
		polybar-msg action "#myupdates.hook.0" >/dev/null 2>&1
	else
		# Hide module if there are 0 updates
		polybar-msg action "#myupdates.module_hide" >/dev/null 2>&1
	fi

	sleep 300 # 5 minutes
done
