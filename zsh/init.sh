#!/bin/zsh

set -o vi

export EDITOR='nvim'
export BROWSER=firefox
export GOPATH=$HOME/Go
export PATH=$PATH:$GOPATH/bin

PWD=`dirname $0`
source "$PWD/prompt.sh"

# Functions
source "$PWD/functions/aur.sh"
source "$PWD/functions/aws.sh"
source "$PWD/functions/creds.sh"

# Zsh
alias sz="source $HOME/.zshrc"

# ls
alias ll='ls -la'
alias lt='ls -lT --git-ignore --git'

# Go
alias gg="go get -v"
alias gv="go mod tidy && go mod vendor"

# Misc
alias wttr="curl wttr.in/Malmö"
