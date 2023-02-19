#!/bin/bash

weather_code=bat ~/.cache/conky-weather.json | jq -r '.weather[0].icon'
cp -r ./icons/${weather_code}.png ~/.cache/conky-weather-icon.png
