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


set string (fd --hidden --type f --ignore-file ~/.config/fd/fdignore-test -a . ~ | fzf --header="open or jump to")


if test -f $string
    # nvim "$string"
    switch $string
        case '*.pdf'
            $PDFVIEWER $string &
        case '*.md' '*.org' '*.txt' '*.conf' '*.yaml' '*.toml' '*.json' '*.hex' '*.c' '*.R' '*.r' '*.rmd' '*.html' '*.bib' '*.fish' '*.sh'
            $EDITOR $string
        # case '*.jpeg' '*.png' '*.jpg'
            # $IMGVIEWER $string &
        case '*.mkv' '*.webm' '*.mp4' '*.avi' '*.mp3' '*.flac' '*.ogg' '*.aac'
            xdg-open $string &
        # case *.mkv *.webm *.mp4 *.avi *.mp3 *.flac *.ogg *.aac
             # mpv --sub-auto=fuzzy $string
        case '*'
            # xdg-open $string &
            # echo "error"
            nvim $string
    end
else if test -d $string
    cd "$string"
    tree -L 1
else
    echo error
end
