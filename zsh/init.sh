#!/bin/zsh

set -o vi

export EDITOR='nvim'
export BROWSER=firefox
if [ "$DESKTOP_SESSION" = "i3" ]; then
    export $(gnome-keyring-daemon -s)
fi
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:$HOME/.config/composer/vendor/bin:$HOME/.gem/ruby/2.5.0/bin
source /usr/share/nvm/init-nvm.sh

PWD=`dirname $0`

# Functions
source "$PWD/functions/aur.sh"
source "$PWD/functions/todo.sh"
source "$PWD/functions/wgt.sh"

# Path shortcuts
source "$PWD/paths/personal.sh"
source "$PWD/paths/work.sh"
