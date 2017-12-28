#!/bin/zsh
if [[ $# -gt 0 ]]; then
  case $1 in
    play)
      mocp -G
      ;;
    pause)
      mocp -G
      ;;
    stop)
      mocp -s
      ;;
    prev)
      mocp -r
      ;;
    next)
      mocp -f
      ;;
    *)
      ;;
  esac
fi

device=/dev/input/ckb1/cmd
if [ -e $device ]; then
  state=`mocp -i | grep State | cut -d\  -f2`

  cmd=""
  case $state in
    PLAY)
      cmd="$cmd rgb f11:008000"
      cmd="$cmd rgb f9:202020"
      ;;
    STOP)
      cmd="$cmd rgb f11:202020"
      cmd="$cmd rgb f9:800000"
      ;;
    PAUSE)
      cmd="$cmd rgb f11:80800"
      cmd="$cmd rgb f9:80800"
      ;;
  esac

  echo $cmd > $device
fi
