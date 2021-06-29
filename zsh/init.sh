#!/bin/zsh

set -o vi

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY_TIME
setopt EXTENDED_HISTORY

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

# Misc
alias wttr="curl wttr.in/Malmö"
