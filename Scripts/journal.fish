#!/bin/fish

set file ~/sync/docs/todo/journal.txt

test -f $file; or notify-send "Journal not found"; or exit

echo \n >> $file

test -f $file; and  date +"%a %H:%M %d.%m.%Y" | sed 's/^/## /' >> $file

# date | cut -d' ' -f1-4

echo \n >> $file



test -f $file; and nvim +normal\ G $file; or notify-send "Can't open journal"
