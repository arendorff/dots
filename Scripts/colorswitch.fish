#!/bin/fish

# set -Ux mytermcolor none

set path home/mo/Dropbox/dots/corsair/.config/alacritty/

# cd ~/Dropbox/dots/corsair/.config/alacritty/

# mv -f "$path"dark-and-light/alacritty.corsair.dark.yml "$path"alacritty.corsair.yml

# mv -f "$path"dark-and-light/alacritty.corsair.light "$path"alacritty.corsair.yml


if test $mytermcolor = dark
    mv -f "$path"dark-and-light/alacritty.corsair.light.yml "$path"alacritty.corsair.yml
    set -Ux mytermcolor light
else if test $mytermcolor = light
    mv -f "$path"dark-and-light/alacritty.corsair.dark.yml "$path"alacritty.corsair.yml
    set -Ux mytermcolor dark
end
