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
