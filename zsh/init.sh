#!/bin/zsh

# set -o vi

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
alias ll='ls -oah'
alias lt='ls -lT --git-ignore --git'

# npm
alias nscr="cat package.json | jq -r '.scripts | to_entries[] | \"\u001b[1m\(.key)\u001b[0m\n    $\(.value)\"'"

# Misc
alias wttr="curl wttr.in/Malmö"
alias tt='tt() { echo -n "\033]2;$1\007" };tt'
alias gg='cd `git rev-parse --show-toplevel`'
