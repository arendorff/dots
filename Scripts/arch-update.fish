#!/bin/fish

set date (date -I)

sudo lvcreate -L 5G -s -n snap-root-$date /dev/vg0/lv-root

# sleep 2

paru -Syu

# --noconfirm
