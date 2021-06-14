#!/bin/fish





function neo
setxkbmap -layout de -variant neo
notify-send "..switching to neo layout"
xmodmap ~/.xmodmap-modified
end

function qwertz
setxkbmap -layout de
notify-send "..switching to qwertz layout"
xmodmap ~/.xmodmap-modified
end

setxkbmap -query | grep -i variant > /dev/null && qwertz || neo
