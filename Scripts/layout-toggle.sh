#!/bin/bash

layout="de"

setxkbmap -query | grep "neo" > /dev/null && layout="neo"



if [[ $layout = "neo" ]]; then
    setxkbmap -layout de
    echo "Layout changed to QWERTZ!"
else
# else if $layout = "de"
    setxkbmap -layout de -variant neo
    echo "Layout changed to Neo2!"
fi
