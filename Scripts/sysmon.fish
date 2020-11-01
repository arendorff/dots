#!/bin/fish

set battery "no battery"

# set battery (acpi -b 2> /dev/null | awk '{print $4}')

# cpu
set cpu (ps -eo pcpu | awk ' {cpu_load+=$1} END {print cpu_load}')

# disk used: percent, total, and used
set diskp (df -h | grep -i '/$' | awk '{print $5}')
set diskf (df -h | grep -i '/$' | awk '{print $2}')
set disku (df -h | grep -i '/$' | awk '{print $3}')

# memory used/full and percent
set memfreec (free --mega | awk '{print $2}' | sed '2q;d' | tr -d 'GiMi')
set memusedc (free --mega | awk '{print $3}' | sed '2q;d' | tr -d 'GiMi')
set memfree (free -h | awk '{print $2}' | sed '2q;d')
set memused (free -h | awk '{print $3}' | sed '2q;d')

# temperature
set temp (sensors -A | awk '{print $2}' | sed '2q;d' | tr -d '+')

# date and time
set date (date | cut -d' ' -f-4)

# wifi
set wifi (nmcli dev | awk '{print $3}' | sed '2q;d' | tr -d '+')

# echo data
echo "---------------------------------"
echo "DISK:        $disku/$diskf ($diskp)"
echo "BATTERY:     $battery"
echo "MEMORY:      $memused/$memfree ""("(math -s2 $memusedc/$memfreec)"%)"
echo "TEMPERATURE: $temp"
echo "DATE:        $date"
echo "WIFI:        $wifi"
echo "CPU:         $cpu%"
echo "---------------------------------"

# if test -n $battery
# echo error
# else
# what
# end


# function dunst
# echo "DISK:        $disku/$diskf ($diskp)"
# echo "BATTERY:     $battery"
# echo "MEMORY:      $memused/$memfree ""("(math -s2 $memusedc/$memfreec)"%)"
# echo "TEMPERATURE: $temp"
# echo "DATE:        $date"
# echo "WIFI:        $wifi"
# end


# dunstify (dunst)
