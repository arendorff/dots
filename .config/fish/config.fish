function cooler
xinput set-prop "Cooler Master Technology Inc. MM710 Gaming Mouse" "libinput Accel Profile Enabled" 0, 1
end

# set -x MANPAGER "nvim -c 'set ft=man' -"
# set -x MANPAGER 'nvim +Man!'
# set -x MANPAGER '/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'

# PATH
set PATH /home/mo/.local/bin $PATH
set PATH /snap/bin/ $PATH
set PATH /usr/local/sbin $PATH
set PATH /sbin $PATH
set PATH /var/lib/flatpak/exports/bin $PATH
set PATH /home/mo/bin/* $PATH
set PATH /home/mo/bin/neovim/bin $PATH
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


function nasmount
sudo mount -t cifs //ubuntu/moritz /mnt/moritz -o credentials=/etc/samba/credentials,workgroup=workgroup,uid=mo,gid=mo,iocharset=utf8
end
function nasumount
sudo umount /mnt/moritz
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
abbr scs 'sudo systemctl status'
abbr sce 'sudo systemctl enable'
abbr scd 'sudo systemctl disable'
abbr mv 'mv -v'
abbr cp 'cp -rv'
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
abbr jn 'cd /mnt/moritz'
abbr jv 'cd ~/Video; ls -GFHh'
abbr js 'cd ~/Scripts; tree'

function cs
cd $argv
ls -GFHh
end


# my public ip
abbr myip 'curl ipinfo.io/ip'
# config files
abbr vrc 'nvim ~/.config/nvim/init.vim'
abbr bashrc 'nvim ~/.bashrc'
abbr trc 'nvim ~/.config/termite/config; cd ~/.config/termite/'
abbr rrc 'nvim ~/.config/ranger/rc.conf'
abbr zrc 'nvim ~/.config/zathura/zathurarc.conf'
abbr lrc 'nvim ~/.config/lf/lfrc'
abbr awrc 'nvim ~/.config/awesome/rc.lua'
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
abbr src "nvim ~/.spectrwm.conf"
abbr arc "nvim ~/.config/alacritty/alacritty.yml"
abbr krc "nvim ~/.config/kitty/kitty.conf"
abbr manrc "nvim ~/.config/vimpager/init.vim"
abbr pagerrc "nvim ~/.config/vimpager/init.vim"
abbr zshrc "nvim ~/.zshrc"
abbr drc 'nvim ~/.config/dunst/dunstrc'
abbr drc 'nvim ~/.config/dunst/dunstrc'

# todo files
abbr tep 'nvim ~/sync/docs/todo/personal.md'
abbr ter 'nvim ~/sync/docs/todo/ricing.md'
abbr tem 'nvim ~/sync/docs/todo/master.md'
abbr teh 'nvim +normal\ G ~/sync/docs/todo/health.md'
abbr thl 'glow ~/sync/docs/todo/health.md'
abbr tpl 'glow ~/sync/docs/todo/personal.md'
abbr trl 'glow ~/sync/docs/todo/ricing.md'
abbr tml 'glow ~/sync/docs/todo/master.md'

# journal
abbr jj journal.fish
abbr jo 'nvim +normal\ G ~/sync/docs/todo/journal.md'

# todo ls
function tls
glow -s dark ~/todo/personal.md ~/todo/ricing.md ~/todo/master.md | less -r
end

#disable ctrl+s BS....necessary in fish?
#stty -ixon

# some more ls abbreviations
abbr ls 'ls -GFHh -1'
abbr ll 'ls -lh'
abbr la 'ls -Alh'
abbr lm 'ls -t -1'
abbr v 'nvim'
# abbr vim 'nvim'
# abbr vi 'nvim'
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
abbr list-orphans "pacman -Qdt"
abbr list-installed-native-packages "pacman -Qent"
abbr list-installed-foreign-packages "pacman -Qemt"
abbr pqs "pacman -Qs" # local search
abbr delete-orphans "sudo pacman -Rns (pacman -Qtdq)" # delete orphaned packages
abbr create-package-list "pacman -Qqen > ~/sync/dots/x250/pkglist.txt"
abbr create-aur-package-list "pacman -Qqem > ~/sync/dots/x250/aurpkglist.txt"

# AUR
abbr ys "paru -S"
abbr yss "paru -Ss"
abbr yrs "paru -Rs"
abbr ysyu "paru -Syu"
# abbr ysyu "paru -Syu"
abbr ysyyu "paru -Syyu"

# apt debian

abbr sai 'sudo aptitude install'
abbr sar 'sudo aptitude remove'
abbr saa 'sudo apt autoremove'
abbr sau 'sudo aptitude update && sudo aptitude upgrade'
abbr safu 'sudo aptitude update && sudo aptitude full-upgrade'

# # fzf apt
# function fai
#     sudo apt install (fzf --header='Install package:' -m --preview 'apt-cache show {1}' < ~/docs/pkglist-debian.txt)
# # pacman -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S
#     # sudo apt install -y (apt list 2>/dev/null | cut -d'/' -f1 | fzf -m)
# end

# function far
#     sudo apt remove (apt list --installed 2>/dev/null | cut -d'/' -f1 | fzf -m)
# end

# define environment variables
set -x EDITOR /usr/bin/nvim
set -x R_PROFILE_USER /home/mo/.config/R/.Rprofile
set -x VISUAL /usr/bin/nvim
#set -Ux EDITOR 'emacs -nw -q'
#set -Ux VISUAL '/usr/bin/emacs -nw'
set -x PAGER /usr/bin/less
set -x IMGVIEWER /usr/bin/sxiv
# set -x PDFVIEWER /usr/bin/evince
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
set -Ux FZF_DEFAULT_COMMAND 'fd --hidden --type f --ignore-file ~/.config/fd/fdignore -a . .'

# fancy fzf for pacman
function fs
pacman -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S
end
# fancy fzf for pacman
function fai
pacman -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S
end

function ffy
yay -Slq | fzf -m --preview 'yay -Si {1}' | xargs -ro sudo pacman -S
end

# fzf pacman remove
function fr
pacman -Qq | fzf -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -Rns
end

# fzf pacman remove
function far
pacman -Qq | fzf -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -Rns
end

function fo
xdg-open (fd --hidden --type f --ignore-file ~/.config/fd/fdignore -a . ~ | fzf --header='Open file') &; disown; exit
end

function fj
cd (fd --hidden --type d --ignore-file ~/.config/fd/fdignore -a . ~ | fzf --header='Jump to location'); pwd; tree -L 1
end

function fja
cd (fd --hidden --type d --ignore-file ~/.config/fd/fdignore -a . / | fzf --header='Jump to location'); pwd; tree -L 1
end

# function cc
# cd (fd --hidden --type d --ignore-file ~/.config/fd/fdignore -a . ~ | fzf --header='Jump to location'); pwd; tree -L 1
# end

# function cc
#     cd $argv
#     tree -L 1 -C
# end

function fv
# nvim (fd --hidden --type f --ignore-file ~/.config/fd/fdignore -a . ~ | fzf --header='Open in Neovim')
fd --hidden --type f --ignore-file ~/.config/fd/fdignore -a . ~ | fzf --header='Open in Neovim' | xargs -ro nvim
end

function fc
fd --hidden --type f -L -a . ~/.config | fzf --header='Open config files' | xargs -ro nvim
end

function fS
nvim (fd --hidden --type f --ignore-file ~/.config/fd/fdignore -a . ~/scripts | fzf --header='Open scripts')
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

abbr bdown brightnessctl set 5%-
abbr bup  brightnessctl set +5%
abbr wifi nmcli device


function trackpoint
xinput set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Speed" 0.3

# trackpoint accel profile
xinput set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Profile Enabled" 0, 1

# tapping enabled
#xinput set-prop 12 286 1
xinput set-prop "Synaptics TM3075-002" "libinput Tapping Enabled" 1



# touchpad drag lock to drage files you can quickly let go and still be in dragging mode.
xinput set-prop "Synaptics TM3075-002" "libinput Tapping Drag Lock Enabled" 1
xinput set-prop "Synaptics TM3075-002" "libinput Tapping Enabled" 1
end


# # colored man pages in fish
# function man --wraps man --description 'Format and display manual pages'
#     set -q man_blink; and set -l blink (set_color $man_blink); or set -l blink (set_color -o red)
#     set -q man_bold; and set -l bold (set_color $man_bold); or set -l bold (set_color -o 5fafd7)
#     set -q man_standout; and set -l standout (set_color $man_standout); or set -l standout (set_color 949494)
#     set -q man_underline; and set -l underline (set_color $man_underline); or set -l underline (set_color -u afafd7)

#     set -l end (printf "\e[0m")

#     set -lx LESS_TERMCAP_mb $blink
#     set -lx LESS_TERMCAP_md $bold
#     set -lx LESS_TERMCAP_me $end
#     set -lx LESS_TERMCAP_so $standout
#     set -lx LESS_TERMCAP_se $end
#     set -lx LESS_TERMCAP_us $underline
#     set -lx LESS_TERMCAP_ue $end
#     set -lx LESS '-R -s'

#     set -lx GROFF_NO_SGR yes # fedora

#     set -lx MANPATH (string join : $MANPATH)
#     if test -z "$MANPATH"
#         type -q manpath
#         and set MANPATH (command manpath)
#     end

#     # Check data dir for Fish 2.x compatibility
#     set -l fish_data_dir
#     if set -q __fish_data_dir
#         set fish_data_dir $__fish_data_dir
#     else
#         set fish_data_dir $__fish_datadir
#     end

#     set -l fish_manpath (dirname $fish_data_dir)/fish/man
#     if test -d "$fish_manpath" -a -n "$MANPATH"
#         set MANPATH "$fish_manpath":$MANPATH
#         command man $argv
#         return
#     end
#     command man $argv
# end


# change colors for man pages, needs fisher plugin
set -g man_blink -o red
set -g man_bold -o blue
# search
set -g man_standout -b yellow black
set -g man_underline -u red

abbr dic "dict -d wn"
abbr trg "dict -d fd-deu-eng"
abbr tre "dict -d fd-eng-deu"

# reflector update mirrorlist germany, latest 10 synchronized mirrors, https only, sort by download speed.
function arch-update-mirrorlist
    sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
    sudo reflector --country germany --protocol https --sort rate --latest 10 --save /etc/pacman.d/mirrorlist
end

# z command open
set -U ZO_METHOD "nvim"

# # fasd
# function vv
#     fasd -f -e nvim
# end

alias vv "fasd -f -e nvim"

function cc
    fasd_cd -d $argv
    pwd
    tree -L 1
end

# rsync to NAS
function nascp
    rsync -vahPru $argv
end
