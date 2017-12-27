#!/bin/zsh
device=/dev/input/ckb1/cmd
if [ -e $device ]; then
  muted=`pamixer --get-mute`

  cmd="active"
  cmd="$cmd rgb 202020"

  # Volume settings
  cmd="$cmd volup:008000 voldn:800000"
  if $muted; then
    cmd="$cmd rgb mute:800000"
  fi

  # Lock
  cmd="$cmd rgb lock:008000"

  # Misc
  cmd="$cmd rgb ins,del:800000"
  cmd="$cmd rgb home,end:008000"
  cmd="$cmd rgb pgup,pgdn:000080"

  # Macros
  cmd="$cmd macro lock:+lalt,+lshift,+p,-p,-lshift,-lalt"

  echo $cmd > $device
fi
