#!/bin/zsh
xrandr --output eDP1 --auto --output HDMI1 --auto --left-of eDP1 --output DP2 --auto --left-of HDMI1 --rotate right
feh --bg-fill ~/.config/wall.png
