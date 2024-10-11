#!/bin/bash

api_key=8c5e491a43b64ecb16ffed40f5c60695
city_id=3459712
units=metric
lang=es
url="api.openweathermap.org/data/2.5/forecast/daily?id=${city_id}&appid=${api_key}&cnt=6&units=${units}&lang=${lang}"
# api.openweathermap.org/data/2.5/forecast/daily?id=3459712&appid=8c5e491a43b64ecb16ffed40f5c60695&cnt=6&units=metric&lang=es
# api.openweathermap.org/data/2.5/forecast?id=3459712&appid=8c5e491a43b64ecb16ffed40f5c60695&units=metric&lang=es
# curl  api.openweathermap.org/data/2.5/forecast?id=3459712&appid=8c5e491a43b64ecb16ffed40f5c60695&units=metric&lang=es -s -o ~/.cache/conky-forecast.json
curl ${url} -s -o ~/.cache/conky-weather.json
# weather icon
# weather_code=$(jq -r '.weather[0].icon' ~/.cache/conky-weather.json)
# echo $weather_code
cp -r ~/.config/conky/icons/$(jq -r '.list | .[0] | .weather | .[].icon' ~/.cache/conky-weather.json).png ~/.cache/conky-weather-icon.png
cp -r ~/.config/conky/icons/$(jq -r '.list | .[1] | .weather | .[].icon' ~/.cache/conky-weather.json).png ~/.cache/conky-weather-icon1.png
cp -r ~/.config/conky/icons/$(jq -r '.list | .[2] | .weather | .[].icon' ~/.cache/conky-weather.json).png ~/.cache/conky-weather-icon2.png
# cp -r ~/.config/conky/icons/$(jq -r '.list | .[3] | .weather | .[].icon' ~/.cache/conky-weather.json).png ~/.cache/conky-weather-icon3.png
# weather_code=bat ~/.cache/conky-weather.json | jq -r '.list | .[0] | .weather | .[].icon'
# cp -r ./icons/${weather_code}.png ~/.cache/conky-weather-icon.png
