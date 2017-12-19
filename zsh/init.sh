#!/bin/zsh

set -o vi

export EDITOR='nvim'
export BROWSER=firefox
if [ "$DESKTOP_SESSION" = "i3" ]; then
    export $(gnome-keyring-daemon -s)
fi
export GOROOT=$HOME/go
export PATH=$PATH:$GOROOT/bin
source /usr/share/nvm/init-nvm.sh

PWD=`dirname $0`

# Functions
source "$PWD/functions/aur.sh"
source "$PWD/functions/todo.sh"
source "$PWD/functions/wgt.sh"

# Path shortcuts
source "$PWD/paths/personal.sh"
source "$PWD/paths/work.sh"
