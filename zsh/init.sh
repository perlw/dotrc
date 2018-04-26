#!/bin/zsh

set -o vi

export EDITOR='nvim'
export BROWSER=firefox
export GOPATH=$HOME/Go
export PATH=$PATH:$GOPATH/bin

PWD=`dirname $0`

## Functions
source "$PWD/functions/aur.sh"

## Navigation
# Passwords
alias sesame="eval \$(op signin my)"

# Configs
alias ez="nvim ~/.zshrc"
alias ezi="nvim ~/Projects/dotrc/zsh/init.sh"
alias sz="source ~/.zshrc"
alias ei="nvim ~/.config/i3/config"
alias eis="nvim ~/.config/i3status/config"

# Navigation
alias gd="cd ~/Downloads"
alias gc="cd ~/.config"
alias gi="cd ~/.config/i3"
alias gg="cd $GOPATH/src"
alias gp="cd ~/Projects"
