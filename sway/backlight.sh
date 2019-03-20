#!/bin/zsh
op="+"
if [[ $# -gt 0 ]]; then
  case $1 in
    inc)
      op="+"
      ;;
    dec)
      op="-"
      ;;
  esac
fi
xbacklight $op 10
current=`xbacklight`
notify-send "Backlight $(( current | 0 ))%" --icon=dialog-information
