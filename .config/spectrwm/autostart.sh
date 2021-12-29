#!/usr/bin/bash


[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
# [[ -f ~/.Xresources.x250 ]] && xrdb -merge -I$HOME ~/.Xresources


# pgrep -x sxhkd || sxhkd -m -1 -c $HOME/.config/sxhkd/sxhkdrc.corsair &
#pgrep -x dropbox || dropbox &
# pgrep -x udiskie || udiskie &
pgrep -x lxqt-policykit-agent || lxqt-policykit-agent &
#pgrep -x emacs || emacs --daemon &
pgrep -x picom || picom &
pgrep -x nm-applet || nm-applet &
# pgrep -x dunst || dunst &
pgrep -x mpd || mpd &
#pkill polybar; $HOME/.config/polybar/launch.sh
#pgrep -x polybar || $HOME/.config/polybar/launch.sh
#pgrep -x polybar || polybar polybar &
pgrep -x redshift || redshift &
# pgrep -x keepassxc || keepassxc &
# pgrep -x nitrogen || nitrogen --restore &
# pgrep -x nextcloud || nextcloud &
# pgrep -x cloud-drive-ui || synology-drive &
pgrep -x unclutter || unclutter -idle 2 &
# pgrep -x /usr/lib/kdeconnectd || /usr/lib/kdeconnectd &
pgrep -x xfce4-power-manager || xfce4-power-manager &
# pgrep cloud-drive || synology-cloud-station-drive &
# hsetroot -solid "#4c6054"
# hsetroot -solid "#353535"
#hsetroot -solid "#000000"
# hsetroot -solid "#181818"
nitrogen --restore
# hsetroot -solid "#505050"
# hsetroot -solid "#181818"
#autorandr -c

# feh --bg-fill ~/images/walls/wallhaven-137ozw.png

# setxbkmap -layout de -variant neo
# exec spectrwm

xsetroot -cursor_name left_ptr &
xset r rate 200 50
xmodmap ~/.xmodmap-modified



# thinkpad specific configuration
# if [ $(hostname) = thinkpad ]
# then
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

# fi

# disable wifi

# sudo ip link set wlp36s0 down
