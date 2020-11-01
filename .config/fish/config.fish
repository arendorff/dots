function cooler
xinput set-prop "Cooler Master Technology Inc. MM710 Gaming Mouse" "libinput Accel Profile Enabled" 0, 1
end

# PATH
set PATH /home/mo/scripts $PATH
set PATH /home/mo/SynologyDrive/dots/x250/Scripts $PATH
set PATH /home/mo/.gem/ruby/2.7.0/bin $PATH
set PATH /home/mo/.emacs.d/bin/ $PATH
set PATH /home/mo/android/platform-tools $PATH
set PATH /home/mo/Games/CARRION $PATH
set PATH /home/mo/Games/* $PATH

#set XDG_DATA_DIRS / flatpak
set XDG_DATA_DIRS ~/.local/share/flatpak/exports/share/applications /var/lib/flatpak/exports/share/applications $XDG_DATA_DIRS

# qt5ct
set -Ux QT_QPA_PLATFORMTHEME qt5ct

# Start X at login
if status is-login
   if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end
end

# functions for hibernate, etc
function hibernate
systemctl hibernate
end

function suspend
systemctl suspend
end

function shutdown
systemctl poweroff
end

function poweroff
systemctl poweroff
end

function reboot
systemctl reboot
end

# functions for NAS mounting and unmounting

#function nasmount
#sudo mount -t cifs //NAS/video /home/mo/NAS/video -o credentials=/etc/samba/credentials/NAS,workgroup=NAS,iocharset=utf8,uid=mo,gid=mo
#sudo mount -t cifs //NAS/stuff /home/mo/NAS/stuff -o credentials=/etc/samba/credentials/NAS,workgroup=NAS,iocharset=utf8,uid=mo,gid=mo
#end

function mbamount
    sudo mount -t cifs //MBA/MBA /home/mo/shares/mba -o username=mo,password=lazarus,workgroup=WORKGROUP,iocharset=utf8,uid=mo,gid=mo
end

function nasmount
sudo mount -t nfs NAS:/volume1/stuff ~/NAS/stuff
sudo mount -t nfs NAS:/volume1/video ~/NAS/video
sudo mount -t nfs NAS:/volume1/cloud ~/NAS/cloud
end
function nasumount
umount /home/mo/NAS/video /home/mo/NAS/stuff /home/mo/NAS/cloud
end

# activate vim keybindings
fish_vi_key_bindings

# empty mode sympbol for vi mode
# function fish_mode_prompt

# end

# function fish_mode_prompt
#      set_color red; echo -n "$fish_bind_mode "
# end

function fish_mode_prompt
  switch $fish_bind_mode
    case default
      set_color --bold red
      echo 'N '
    case insert
      set_color --bold green
      echo 'I '
    case replace_one
      set_color --bold green
      echo 'R '
    case visual
      set_color --bold brmagenta
      echo 'V '
    case '*'
      set_color --bold red
      echo '? '
  end
  set_color normal
end


# cutom keybindings for vi mode
function fish_user_key_bindings
    bind -m default T end-of-line
    bind -m default S beginning-of-line
    bind -m default s backward-char
    bind -m default t forward-char
    #bind -m default r up-or-search
    #bind -m default n down-or-search
end
#fish_default_key_bindings

# reload
abbr reload 'xrdb ~/.Xresources'

# programs
abbr g 'git'
abbr gp 'git push -u origin master'
abbr gs 'git status'
abbr gpp 'git pull'
abbr ga 'git add'
abbr gc 'git commit -m "'
abbr cat 'bat'
abbr R 'R --quiet'
abbr df 'df -h'
abbr vpn 'nordvpn'
abbr vpns 'nordvpn status'
abbr vpnS 'nordvpn settings'
abbr vpnke 'nordvpn set killswitch enabled'
abbr vpnkd 'nordvpn set killswitch disabled'
abbr vpnc 'nordvpn connect'
abbr vpnd 'nordvpn disconnect'
abbr ytdl 'youtube-dl'
abbr r ranger
abbr l lfcd
abbr sc 'systemctl'
abbr scs 'systemctl status'
abbr sce 'systemctl enable'
abbr scd 'systemctl disable'
abbr mv 'mv -iv'
abbr cp 'cp -riv'
abbr mkdir 'mkdir -vp'
abbr rm 'rm -rv'

abbr ytdlv 'youtube-dl --no-playlist --no-overwrites --ignore-errors --skip-unavailable-fragments --fragment-retries 0 -o "~/Video/%(uploader)s - %(title)s.%(ext)s" -f "bestvideo[height<=720]+bestaudio/best[height<=720]" "'
abbr ytdlp 'youtube-dl --yes-playlist --no-overwrites --ignore-errors --skip-unavailable-fragments --fragment-retries 0 -o "~/Video/%(uploader)s/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" -f "bestvideo[height<=720]+bestaudio/best[height<=720]" "'

# jumping
abbr jh 'cd ~; ls -GFHh'
abbr ju 'cd ~/SynologyDrive/Documents/master; ls -GFHh'
abbr jb 'cd ~/Dropbox; ls -GFHh'
abbr jg 'cd ~/Games; ls -GFHh'
abbr jd 'cd ~/Downloads; ls -GFHh'
abbr jD 'cd ~/Documents; ls -GFHh'
abbr jm 'cd ~/SynologyDrive/Documents/master; ls -GFHh'
abbr jc 'cd ~/.config; ls -GFHh'
abbr jC 'cd ~/Cloud; ls -GFHh'
abbr j. 'cd ~/dotfiles; ls -GFHh'
abbr jn 'cd ~/SynologyDrive/Documents/master/notes; ls -GFHh'
abbr jv 'cd ~/Video; ls -GFHh'
abbr js 'cd ~/Scripts; tree'

function cs
cd $argv
ls -GFHh
end

# config files
abbr vrc 'nvim ~/.config/nvim/init.vim'
abbr bashrc 'nvim ~/.bashrc'
abbr trc 'nvim ~/.config/termite/config; cd ~/.config/termite/'
abbr rrc 'nvim ~/.config/ranger/rc.conf'
abbr zrc 'nvim ~/.config/zathura/zathurarc.conf'
abbr lrc 'nvim ~/.config/lf/lfrc'
abbr frc "nvim ~/.config/fish/config.fish"
abbr orc "nvim ~/.config/openbox/rc.xml"
abbr crc "nvim ~/.config/compton.conf"
abbr initel "nvim ~/.emacs.d/init.el"
abbr erc "nvim ~/.emacs.d/config.org"
abbr xres "nvim ~/.Xresources"
abbr xinit "nvim ~/.xinitrc"
abbr bspwmrc "nvim ~/.config/bspwm/bspwmrc"
abbr brc "nvim ~/.config/bspwm/bspwmrc"
abbr swayrc "nvim ~/.config/sway/config"
abbr sxhkdrc "nvim ~/.config/sxhkd/sxhkdrc"
abbr src "nvim ~/.config/sxhkd/sxhkdrc"
abbr arc "nvim ~/.config/alacritty/alacritty.yml"
abbr manrc "nvim ~/.config/vimpager/init.vim"
abbr pagerrc "nvim ~/.config/vimpager/init.vim"
abbr zshrc "nvim ~/.zshrc"
abbr drc 'nvim ~/.config/dunst/dunstrc'
abbr drc 'nvim ~/.config/dunst/dunstrc'

# todo files
abbr tp 'nvim ~/todo/personal.md'
abbr tr 'nvim ~/todo/ricing.md'
abbr tm 'nvim ~/todo/master.md'
abbr th 'nvim ~/todo/health.md'
abbr thl 'glow ~/todo/health.md'
abbr tpl 'glow ~/todo/personal.md'
abbr trl 'glow ~/todo/ricing.md'
abbr tml 'glow ~/todo/master.md'

# journal
abbr jj journal.fish
abbr jo 'nvim +normal\ G ~/todo/journal.md'

# todo ls
function tls
glow -s dark ~/todo/personal.md ~/todo/ricing.md ~/todo/master.md | less -r
end

#disable ctrl+s BS....necessary in fish?
#stty -ixon

# some more ls abbreviations
abbr ls 'ls -GFHh'
abbr ll 'ls -lh'
abbr la 'ls -Alh'
abbr v 'nvim'
abbr vim 'nvim'
abbr vi 'nvim'
abbr pseg 'ps -e | grep -i '

# udiskie
abbr umounta "udiskie-umount -a"
abbr mounta "udiskie-mount -a"

# pacman
abbr sps "sudo pacman -S" # install
abbr pss "pacman -Ss" # search for packages
abbr sprs "sudo pacman -Rs" # remove package and unneeded dependencies
abbr sprns "sudo pacman -Rns" # remove package and unneeded dependencies
abbr prns "pacman -Rns" # remove package and unneeded dependencies
abbr prs "sudo pacman -Rs" # remove package and unneeded dependencies
abbr spsyu "sudo pacman -Syu" # update repository database und packages
abbr psyu "sudo pacman -Syu" # update repository database und packages
abbr psi "pacman -Si" # info on package in repos.
abbr pqi "pacman -Qi" # info on local package
abbr listorphans "pacman -Qdt"
abbr pqs "pacman -Qs" # local search
abbr locallist "pacman -Qet"  #list all explicitly installed packages
abbr deleteorphans "sudo pacman -Rns (pacman -Qtdq)" # delete orphaned packages

# AUR
abbr ys "yay -S"
abbr yss "yay -Ss"
abbr yrs "yay -Rs"
abbr ysyu "yay -Syu"
abbr ysyyu "yay -Syyu"

# define environment variables
set -x EDITOR /usr/bin/nvim
set -x R_PROFILE_USER /home/mo/.config/R/.Rprofile
set -x VISUAL /usr/bin/nvim
#set -Ux EDITOR 'emacs -nw -q'
#set -Ux VISUAL '/usr/bin/emacs -nw'
set -x PAGER /usr/bin/less
set -x IMGVIEWER /usr/bin/sxiv
set -x PDFVIEWER /usr/bin/zathura
# set -x TERM /usr/bin/alacritty
set -x BROWSER /usr/bin/firefox
# set -x WM /usr/bin/bspwm
set -x WM /usr/bin/spectrwm

# fix keyboard shit with fish and bspwm
set -Ux SXHKD_SHELL "/usr/bin/bash"

# set layout
function neo
setxkbmap -layout de -variant neo
end

# define default fzf command for vim
set -Ux FZF_DEFAULT_COMMAND 'fd --hidden --type f --ignore-file ~/.config/fd/fdignore-test -a . .'

# fancy fzf for pacman
function ffs
pacman -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S
end

function ffy
yay -Slq | fzf -m --preview 'yay -Si {1}' | xargs -ro sudo pacman -S
end
# fzf pacman remove
function ffr
pacman -Qq | fzf -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -Rns
end

function ffo
xdg-open (fd --hidden --type f --ignore-file ~/.config/fd/fdignore-test -a . ~ | fzf --header='Open file') &; disown; exit
end

function ffj
cd (fd --hidden --type d --ignore-file ~/.config/fd/fdignore-test -a . ~ | fzf --header='Jump to location'); pwd; tree -L 1
end

function cc
cd (fd --hidden --type d --ignore-file ~/.config/fd/fdignore-test -a . ~ | fzf --header='Jump to location'); pwd; tree -L 1
end

function ffv
# nvim (fd --hidden --type f --ignore-file ~/.config/fd/fdignore-test -a . ~ | fzf --header='Open in Neovim')
fd --hidden --type f --ignore-file ~/.config/fd/fdignore-test -a . ~ | fzf --header='Open in Neovim' | xargs -ro nvim
end

function ffc
fd --hidden --type f -L -a . ~/.config | fzf --header='Open config files' | xargs -ro nvim
end

function ffS
nvim (fd --hidden --type f --ignore-file ~/.config/fd/fdignore-test -a . ~/scripts | fzf --header='Open scripts')
end

function ff
. ~/Scripts/fzfscript.fish
end

function report
date
acpi -b
end

# flatpak abbreviations
abbr fps flatpak search
abbr fpi flatpak install
abbr fpr flatpak run
abbr fpu flatpak update

# youtube-dl scripts
abbr ytp ytp.fish
abbr ytv ytv.fish

# date
abbr now 'date "+%H:%M %d.%m.%Y"'

# systemctl
abbr ssc 'sudo systemctl'

# day night switch
function day
    wal --theme base16-tomorrow -l
    hsetroot -solid "#ffffff"
    bspc wm -r
end

function night
    wal --theme base16-tomorrow-night
    hsetroot -solid "#1d1f21"
    bspc wm -r
end

function default-dark
    wal --theme base16-default
    hsetroot -solid "#181818"
    bspc wm -r
end

function default-light
    wal --theme base16-default -l
    hsetroot -solid "#f8f8f8"
    bspc wm -r
end


# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# cat ~/.cache/wal/sequences &

# Alternative (blocks terminal for 0-3ms)
# cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
# source ~/.cache/wal/colors-tty.sh
