#!/bin/fish

fc-list | fzf | awk '{print $1}' | sed 's/://g' | xargs -r display
