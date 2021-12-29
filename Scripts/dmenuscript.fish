#!/bin/fish

# function ffo
# xdg-open (fd --hidden --type f --ignore-file ~/.config/fd/fdignore-test -a . ~  fzf --header='Open file') &; disown
# end

# function ffj
# cd (fd --hidden --type d --ignore-file ~/.config/fd/fdignore-test -a . ~  fzf --header='Jump to location'); pwd; tree -L 1
# end

# function ffv
# # nvim (fd --hidden --type f --ignore-file ~/.config/fd/fdignore-test -a . ~  fzf --header='Open in Neovim')
# fd --hidden --type f --ignore-file ~/.config/fd/fdignore-test -a . ~  fzf --header='Open in Neovim'  xargs -ro nvim
# end

# function ffc
# fd --hidden --type f --ignore-file ~/.config/fd/fdignore-test -a . ~/.config  fzf --header='Open config files'  xargs -ro nvim
# end

# function ffS
# nvim (fd --hidden --type f --ignore-file ~/.config/fd/fdignore-test -a . ~/Scripts  fzf --header='Open scripts')
# end


# set string (fd --hidden --type f --ignore-file ~/.config/fd/fdignore -a . ~ | dmenu -fn "Terminus-12" -nf "#c5c8c6" -nb "#1d1f21" -sb "#81a2be" -sf "#1d1f21" -i -l 25)
set string (fd --hidden --type f --ignore-file ~/.config/fd/fdignore -a . ~ | dmenu -nf "#c5c8c6" -nb "#1d1f21" -sb "#81a2be" -sf "#1d1f21" -i -l 25)

        # dmenu_run -i -fn "Terminus-12" -nf "#c5c8c6" -nb "#1d1f21" -sb "#81a2be" -sf "#1d1f21"

        echo $string

if test -f $string
    # nvim "$string"
    switch $string
        case '*.pdf'
            # zathura $string &
            evince $string &
        case '*.epub' '*.mobi'
            open $string &
            # foliate $string &
        case '*.md' '*.org' '*.txt' '*.conf' '*.yaml' '*.yml' '*.toml' '*.json' '*.hex' '*.c' '*.R' '*.r' '*.rmd' '*.html' '*.bib' '*.fish' '*.sh'
            alacritty -e $EDITOR $string
            # alacritty -e $EDITOR $string
        case '*.jpeg' '*.png' '*.jpg'
            $IMGVIEWER $string &
        case '*.mkv' '*.webm' '*.mp4' '*.avi' '*.mp3' '*.flac' '*.ogg' '*.aac'
            xdg-open $string &
        # case *.mkv *.webm *.mp4 *.avi *.mp3 *.flac *.ogg *.aac
        #      mpv --sub-auto=fuzzy $string
        case '*'
            # xdg-open $string &
            # alacritty -e $EDITOR $string
            # echo "error"
            notify-send "error"
            # nvim $string
    end
# else if test -d $string
    # # setsid -f nautilus $string
    # alacritty -e cd $string; lfcd
    # # cd "$string"
    # # tree -L 1
# else if test -z $string
    # notify-send "exiting..."
else
    notify-send "aborting search"
end
