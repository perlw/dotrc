#!/bin/zsh

setupDiaryTemplate() {
  if [ ! -f "template.md" ]; then
    print -P '%F{red}missing template.md%f'
    return 1
  fi

  filename="$(date +%Y-%m-%d).md"
  if [ -f "$filename" ]; then
    print -P '%F{red}a file for the day already exists!%f'
    return 1
  fi

  cp template.md $filename
}

fixInput() {
  setxkbmap -option caps:escape se
  xinput --set-prop 'Logitech Gaming Mouse G400' 'libinput Accel Speed' -0.5
}

alias diary='setupDiaryTemplate'
alias fix-input='fixInput'
