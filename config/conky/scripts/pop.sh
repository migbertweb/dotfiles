#!/bin/bash

pop_1=$(bat ~/.cache/conky-weather.json | jq '.list | .[0] | .pop')
base100=100
# pop=$(echo 'pop_1=$(bat ~/.cache/conky-weather.json | jq '.list | .[0] | .pop') * base100=100' | bc);echo $pop
