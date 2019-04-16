#!/bin/sh
# Give dmenu list of all unicode characters to copy.
# Shows the selected character in dunst if running.

cmd="$MENU -p emoji -l 20"
chosen=$(grep -v "#" ~/.config/sway/emoji | eval $cmd)

[ "$chosen" != "" ] || exit

c=$(echo "$chosen" | sed "s/ .*//")
echo "$c" | tr -d '\n' | wl-copy
notify-send "'$c' copied to clipboard." &
