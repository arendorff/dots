#!/bin/bash

url=$(xsel -ob)

notify-send "trying to play $url"

# mpv --fs --ytdl-format=22 "$url" || mpv --fs "$url"
mpv --ytdl-format=22 "$url" || mpv "$url"
