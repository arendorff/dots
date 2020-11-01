#!/bin/fish



notify-send "downloading audio..." && youtube-dl --no-overwrites --ignore-errors --skip-unavailable-fragments --fragment-retries 0 -o "~/Audio/%(uploader)s - %(title)s.%(ext)s" -f 'bestaudio' > /dev/null (xclip -o -sel clip)




# youtube-dl --no-playlist --no-overwrites --ignore-errors --skip-unavailable-fragments --fragment-retries 0 -o "~/Video/%(uploader)s - %(title)s.%(ext)s" -f "bestvideo[height<=720]+bestaudio/best[height<=720]" $argv
