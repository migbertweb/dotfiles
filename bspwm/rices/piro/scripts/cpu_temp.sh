#!/usr/bin/env bash

# Script to get CPU temperature from sensors output (Package id 0)
# Designed for Polybar custom/script module

# Use sensors to get the coretemp data and extract the Package id 0 temperature
# The output format of sensors for coretemp-isa-0000 looks like:
# Package id 0:  +65.0°C  (high = +100.0°C, crit = +100.0°C)

temp=$(sensors coretemp-isa-0000 | grep "Package id 0:" | awk '{print $4}' | tr -d '+')

if [ -n "$temp" ]; then
	echo "$temp"
else
	echo "N/A"
fi
