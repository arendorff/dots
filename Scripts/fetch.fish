#!/bin/fish

# uptime
set uptime (uptime | cut -d' ' -f4-5 | tr -d ',')

# packages
set packages (pacman -Qq | wc -l)

# cpu
set cpu (lshw | awk .....

or use lscpu

lshw -quiet -short 2> /dev/null | awk '/processor/' | cut -d' ' -f1-2


# gpu

# disk used: percent, total, and used
set diskp (df -h | grep -i '/$' | awk '{print $5}')
set diskf (df -h | grep -i '/$' | awk '{print $2}')
set disku (df -h | grep -i '/$' | awk '{print $3}')
# simpler
set disk (df -h | awk '/\/$/ {print $3 "/" $2 " (" $5 ")"}')

# # memory used/full and percent
# set memfreec (free --mega | awk '{print $2}' | sed '2q;d' | tr -d 'GiMi')
# set memusedc (free --mega | awk '{print $3}' | sed '2q;d' | tr -d 'GiMi')
# set memfree (free -h | awk '{print $2}' | sed '2q;d')
# set memused (free -h | awk '{print $3}' | sed '2q;d')

# simpler
set memory (free -h | awk '/^Mem:/ {print $3 "/" $2}')
# theme

# shell
set shell (fish -v | cut -d' ' -f1,3 | tr -d ',')

# wm - doesn't work somehow
set $winman (echo $WM | cut -d'/' -f47)

# printout
echo \n
echo "------------------------------"
set_color red; printf "HOSTNAME:   "; set_color normal; echo (hostname)
set_color red; printf "USER:       "; set_color normal; echo (whoami)
set_color red; printf "WM:         "; set_color normal; echo $WM
set_color red; printf "TERMINAL:   "; set_color normal; echo $TERM
set_color red; printf "KERNEL      "; set_color normal; echo (uname -r)
set_color red; printf "OS:         "; set_color normal; echo (uname -o)
set_color red; printf "SHELL:      "; set_color normal; echo "$shell"
set_color red; printf "PACKAGES:   "; set_color normal; echo "$packages"
set_color red; printf "DISK:       "; set_color normal; echo "$disk"
set_color red; printf "MEMORY:     "; set_color normal; echo "$memory"
echo "------------------------------"
echo \n


# # user and host
# echo \n
# echo -----------------------------------------
# printf "| "; set_color red; printf "HOSTNAME:   "; set_color normal; echo (hostname)
# printf "| "; set_color red; printf "USER:       "; set_color normal; echo (whoami)
# printf "| "; set_color red; printf "WM:         "; set_color normal; echo $WM
# printf "| "; set_color red; printf "TERMINAL:   "; set_color normal; echo $TERM
# printf "| "; set_color red; printf "KERNEL      "; set_color normal; echo (uname -r)
# printf "| "; set_color red; printf "OS:         "; set_color normal; echo (uname -o)
# printf "| "; set_color red; printf "SHELL:      "; set_color normal; echo "$shell"
# printf "| "; set_color red; printf "PACKAGES:   "; set_color normal; echo "$packages"
# printf "| "; set_color red; printf "DISK:       "; set_color normal; echo "$disku/$diskf ($diskp)"
# printf "| "; set_color red; printf "MEMORY:     "; set_color normal; echo "$memused/$memfree ("(math -s2 $memusedc/$memfreec)"%)"
# echo -----------------------------------------
# echo \n
