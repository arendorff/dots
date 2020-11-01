#!/usr/bin/bash

#load xresources
#[[ $(hostname) = x250 ]] && [[ -f ~/.Xresources.x250 ]] && xrdb -merge -I$HOME ~/.Xresources.x250
#[[ $(hostname) = corsair ]] && [[ -f ~/.Xresources.corsair ]] && xrdb -merge -I$HOME ~/.Xresources.corsair

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
# [[ -f ~/.Xresources.x250 ]] && xrdb -merge -I$HOME ~/.Xresources

# pywal
#wal -R

pgrep -x sxhkd || sxhkd -m -1 -c $HOME/.config/sxhkd/sxhkdrc.corsair &
#pgrep -x dropbox || dropbox &
pgrep -x udiskie || udiskie &
#pgrep -x emacs || emacs --daemon &
#pgrep -x picom || picom &
pgrep -x dunst || dunst &
pgrep -x mpd || mpd &
#pkill polybar; $HOME/.config/polybar/launch.sh
#pgrep -x polybar || $HOME/.config/polybar/launch.sh
#pgrep -x polybar || polybar polybar &
pgrep -x redshift || redshift &
# pgrep -x cloud-drive-ui || synology-drive &
pgrep -x unclutter || unclutter --timeout 2 &
pgrep -x xfce4-power-manager || xfce4-power-manager &
pgrep cloud-drive || synology-cloud-station-drive &
# hsetroot -solid "#4c6054"
# hsetroot -solid "#353535"
hsetroot -solid "#000000"
#autorandr -c

exec spectrwm

xsetroot -cursor_name left_ptr &
# setxbkmap -layout de -variant neo
xset r rate 200 50
xmodmap ~/.xmodmap-modified



# thinkpad specific configuration
if [ $(hostname) = x250 ]
then
# trackpoint acceleration speed
xinput set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Speed" 0.3

# trackpoint accel profile
xinput set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Profile Enabled" 0, 1

# tapping enabled
#xinput set-prop 12 286 1
xinput set-prop "Synaptics TM3075-002" "libinput Tapping Enabled" 1



# touchpad drag lock to drage files you can quickly let go and still be in dragging mode.
xinput set-prop "Synaptics TM3075-002" "libinput Tapping Drag Lock Enabled" 1
xinput set-prop "Synaptics TM3075-002" "libinput Tapping Enabled" 1

fi
