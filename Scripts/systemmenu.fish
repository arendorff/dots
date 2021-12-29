#!/bin/fish

# run dmenu to ask the user what to do and save anwser in variable
set var (echo -e "shutdown\nreboot\nescape\nexit\nsuspend\nhibernate" | dmenu -p "Run: " -fn "Terminus-12" -nf "#c5c8c6" -nb "#1d1f21" -sb "#81a2be" -sf "#1d1f21" -i)

# echo $var

# execute command based on the value of variable
switch $var
    case shutdown
        systemctl poweroff
    case reboot
        systemctl reboot
    case hibernate
        systemctl hibernate
    case suspend
        systemctl suspend
    case exit
        killall spectrwm; or killall bspwm; or killall openbox; or killall awesome
    case escape
        notify-send "Exiting script..."
    case '*'
        notify-send "Error..."
end
