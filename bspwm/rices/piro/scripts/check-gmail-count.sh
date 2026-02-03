#!/usr/bin/env bash

# File for polybar module 'gmail' to read
GMAIL_COUNT_FILE="$HOME/.tmp/gmail_unread_count"

# Ensure only one instance runs
if pgrep -x -f "$(readlink -f "$0")" | grep -v $$ >/dev/null; then
	exit 0
fi

while true; do
	# Get unread count from the file
	# Format of the file according to cat: "   1 1" or similar, we need the number.
	# We'll use awk to get the first numeric field.
	if [ -f "$GMAIL_COUNT_FILE" ]; then
		unread=$(cat "$GMAIL_COUNT_FILE" | awk '{print $1}')
	else
		unread=0
	fi

	# Ensure unread is a number
	if ! [[ "$unread" =~ ^[0-9]+$ ]]; then
		unread=0
	fi

	# Output the count (useful for manual execution or debugging)
	echo "$unread"

	# Notify polybar modules
	if [ "$unread" -gt 0 ]; then
		# Show module and refresh hook if there are unread emails
		polybar-msg action "#gmail.module_show" >/dev/null 2>&1
		polybar-msg action "#gmail.hook.0" >/dev/null 2>&1
	else
		# Hide module if there are 0 unread emails
		polybar-msg action "#gmail.module_hide" >/dev/null 2>&1
	fi

	sleep 60 # Check every minute
done
