#!/usr/bin/env bash

# update pywal
#(wal -R &)
# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done


#[ $(hostname) = "manjaro" ] && polybar -r -c /home/mo/Cloud/ 
# Launch bar1 and bar2
polybar eDP1 -r &
polybar DP2 -r &
# polybar bar2 &

##if type "xrandr"; then
##  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
##    MONITOR=$m polybar --reload example &
##  done
##else
##  polybar --reload example &
##fi


