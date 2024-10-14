#!/bin/bash

weather_code=bat ~/.cache/conky-weather.json | jq -r '.list | .[0] | .weather | .[].icon'
cp -r ./icons/${weather_code}.png ~/.cache/conky-weather-icon.png
