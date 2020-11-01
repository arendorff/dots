#!/bin/fish

set date (date +"%a %H:%M %d.%m.%Y")

set bat (acpi -b | cut -d' ' -f4 | tr -d ',')

notify-send "DATE: $date"
# BAT: $bat"
