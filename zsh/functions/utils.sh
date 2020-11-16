#!/bin/zsh

setupDiaryTemplate() {
  if [ ! -f "template.md" ]; then
    print -P '%F{red}missing template.md%f'
    return 1
  fi

  filename="$(date +%Y-%m-%d).md"
  if [ ! -f "$filename" ]; then
    cp template.md $filename
  fi

  $EDITOR $filename
}

fixInput() {
  setxkbmap -option caps:escape se
  xinput --set-prop 'Logitech Gaming Mouse G400' 'libinput Accel Speed' -0.5
}

alias diary='setupDiaryTemplate'
alias fix-input='fixInput'
