#!/bin/bash

d1=$(jq -r ".list | .[1].dt" ~/.cache/conky-weather.json)
conv=$(date -d @${d1} +%a/%d)
echo $conv
# d1=$(jq -r '.list | .[1].dt' ~/.cache/conky-weather.json)
# d2=$(jq -r '.list | .[2].dt' ~/.cache/conky-weather.json)
# d3=$(jq -r '.list | .[3].dt' ~/.cache/conky-weather.json)
# conv1=$(date -d @${d1} +%a/%d)
# conv2=$(date -d @${d2} +%a/%d)
# conv3=$(date -d @${d3} +%a/%d)
# echo $conv1
# echo $conv2
# echo $conv3
