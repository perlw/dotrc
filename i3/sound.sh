#!/bin/zsh
op="-i"
if [[ $# -gt 0 ]]; then
  case $1 in
    inc)
      op="-i 5"
      ;;
    dec)
      op="-d 5"
      ;;
    mute)
      op="-t"
      ;;
  esac
fi
pamixer $op

device=/dev/input/ckb1/cmd
if [ -e $device ]; then
  muted=`pamixer --get-mute`
  volume=`pamixer --get-volume`

  cmd=""
  if $muted; then
    cmd="rgb mute:800000"
  else
    cmd="rgb mute:101010"
  fi
  echo $cmd > $device
fi
