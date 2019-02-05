#!/bin/zsh
op="-i"
arg=""
if [[ $# -gt 0 ]]; then
  case $1 in
    inc)
      op="-i"
      arg=5
      ;;
    dec)
      op="-d"
      arg=5
      ;;
    mute)
      op="-t"
      ;;
  esac
fi
pamixer $op $arg
pkill -RTMIN+10 i3blocks
