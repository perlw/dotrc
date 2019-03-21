#!/bin/sh
# Give dmenu list of all unicode characters to copy.
# Shows the selected character in dunst if running.

chosen=$(grep -v "#" ~/.config/sway/emoji | bemenu -i -l 20)

[ "$chosen" != "" ] || exit

c=$(echo "$chosen" | sed "s/ .*//")
echo "$c" | tr -d '\n' | wl-copy
notify-send "'$c' copied to clipboard." &
