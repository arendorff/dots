#!/bin/fish

nordvpn status | grep "Connected" >/dev/null; and set vpn connected; or set vpn disconnected

set name (nmcli dev | grep "^wlp3.*" | awk '{print$4}')

set date (date +"%a %H:%M %d.%m.%Y")

set bat (acpi -b | cut -d' ' -f3,4 | tr -d ',')
# set bat (acpi -b | cut -d' ' -f3,4 | tr -d ',')

notify-send "DATE: $date
BAT: $bat
WIFI: $name
VPN: $vpn"




# echo $name



# nmcli dev | grep '^wlp3s0.*connected' > /dev/null && notify-send "wifi connected to $name" || notify-send "wifi disconnected"
