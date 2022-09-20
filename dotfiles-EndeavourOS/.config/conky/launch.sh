#!/usr/bin/env bash

# Terminate already running conky instances
killall -q conky

# Launch
conky -p 3 --config=conky.conf &

