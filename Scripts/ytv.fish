#!/bin/fish

youtube-dl --no-playlist --no-overwrites --ignore-errors --skip-unavailable-fragments --fragment-retries 0 -o "~/Video/%(uploader)s - %(title)s.%(ext)s" -f "bestvideo[height<=720]+bestaudio/best[height<=720]" $argv
