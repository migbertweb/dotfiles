#!/usr/bin/env bash

# Terminate already running conky instances
killall -q conky

# Launch
conky -p 1 --config=conky.conf &

