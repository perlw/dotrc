#!/bin/zsh

set -o vi

export EDITOR='nvim'
export BROWSER=firefox
export GOPATH=$HOME/Go
export PATH=$PATH:$GOPATH/bin

PWD=`dirname $0`

# Functions
source "$PWD/functions/aur.sh"
source "$PWD/functions/aws.sh"
source "$PWD/functions/creds.sh"

# Zsh
alias sz="source $HOME/.zshrc"

# Go
alias gg="go get -v"
alias gv="go mod tidy && go mod vendor"

# Misc
alias wttr="curl wttr.in/Malmö"

# Work
alias wgu="wg-quick up $HOME/.config/wireguard/wg0.conf"
alias wgd="wg-quick down $HOME/.config/wireguard/wg0.conf"
