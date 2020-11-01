#!/bin/fish


# nmcli dev | grep "\sconnected"; and notify-send "Enabling Wifi..."; and nmcli device connect wlp3s0; or notify-send "Disabling Wifi..."; and





# check if wifi is connected or not
nmcli device | grep "\sconnected" > /dev/null

# $status saves output value of last command. If it failed (1), than do x, else y
if test $status -eq 1
notify-send "Enabling Wifi..."
nmcli device connect wlp3s0 > /dev/null
else
notify-send "Disabling Wifi..."
nmcli device disconnect wlp3s0 > /dev/null
end
