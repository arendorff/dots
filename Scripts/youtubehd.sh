#!/bin/bash

url=$(xsel -ob)

notify-send "playing $url"

mpv --fs "$url"
