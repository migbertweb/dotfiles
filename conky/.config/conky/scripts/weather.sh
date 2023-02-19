#!/bin/bash

api_key=8c5e491a43b64ecb16ffed40f5c60695
city_id=3459712
units=metric
lang=es
url="api.openweathermap.org/data/2.5/weather?id=${city_id}&appid=${api_key}&units=${units}&lang=${lang}"
curl ${url} -s -o ~/.cache/conky-weather.json
# weather icon
weather_code=$(jq -r '.weather[0].icon' ~/.cache/conky-weather.json)
# echo $weather_code
cp -r ~/.config/conky/icons/$(jq -r '.weather[0].icon' ~/.cache/conky-weather.json).png ~/.cache/conky-weather-icon.png
