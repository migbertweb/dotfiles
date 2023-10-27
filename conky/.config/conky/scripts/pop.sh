#!/bin/bash

pop_1=$(bat ~/.cache/conky-weather.json | jq '.list | .[0] | .pop')
base100=100
pop=$(($pop_1*$base100))
echo $pop
