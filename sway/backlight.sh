#!/bin/zsh
if [[ $# -gt 0 ]]; then
  case $1 in
    inc)
      brightnessctl s +10%
      ;;
    dec)
      current=`brightnessctl -m | cut -d , -f 3`
      if [[ $current -gt 150 ]]; then
        brightnessctl s 10%-
      fi
      ;;
  esac
fi
current=`brightnessctl -m | cut -d , -f 4`
notify-send "Backlight $current" --icon=dialog-information
