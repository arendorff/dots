#!/bin/sh


setxkbmap -query | grep -i "neo" >/dev/null && setxkbmap -layout de || setxkbmap -layout de -variant neo


