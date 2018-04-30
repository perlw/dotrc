#!/bin/zsh

set -o vi

export EDITOR='nvim'
export BROWSER=firefox
export GOPATH=$HOME/Go
export PATH=$PATH:$GOPATH/bin

PWD=`dirname $0`

## Functions
source "$PWD/functions/aur.sh"

# Passwords
alias sesame="eval \$(op signin my)"

# Configs
alias ez="nvim $HOME/.zshrc"
alias ezi="nvim $HOMe/Projects/dotrc/zsh/init.sh"
alias sz="source $HOME/.zshrc"
alias ei="nvim $HOME/.config/i3/config"
alias eis="nvim $HOME/.config/i3status/config"
alias er="nvim $HOME/.config/ranger/rc.conf"

# Navigation
alias gd="cd $HOME/Downloads"
alias gc="cd $HOME/.config"
alias gci="cd $HOME/.config/i3"
alias gtg="cd $GOPATH/src/github.com/perlw"
alias gp="cd $HOME/Projects"
alias gw="cd $HOME/Work"

# Misc
alias wttr="curl wttr.in/Malmö"
