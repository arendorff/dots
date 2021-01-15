#!/bin/fish

set name (nmcli dev | grep "^wlp3s0" | awk '{print$4}')


# echo $name



nmcli dev | grep '^wlp3s0.*connected' > /dev/null && notify-send "wifi connected to $name" || notify-send "wifi disconnected"
