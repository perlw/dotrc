#!/bin/zsh

set -o vi

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000
export LESSCHARSET=UTF-8

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY_TIME
setopt EXTENDED_HISTORY

export EDITOR='nvim'
export GOPATH=$HOME/Go
export PATH=$PATH:$GOPATH/bin

PWD=`dirname $0`
source "$PWD/prompt.sh"

# Zsh
alias sz="source $HOME/.zshrc"

# ls
if [ `uname` = 'Linux' ]; then
  alias ls='ls --color=auto'
fi
alias ll='ls -oah'

# npm
alias nscr="cat package.json | jq -r '.scripts | to_entries[] | \"\u001b[1m\(.key)\u001b[0m\n    $\(.value)\"'"

ridiculusPushDirModified() {
  pushd `git ss | grep ^UU | head -n 1 | cut -d ' ' -f 2 | xargs dirname`
}

# Misc
alias wttr="curl wttr.in/Malmö"
alias tt='tt() { echo -n "\033]2;$1\007" };tt'
alias gg='cd `git rev-parse --show-toplevel`'
alias puu='ridiculusPushDirModified'
alias re="git ss | grep ^UU | cut -d ' ' -f 2 | xargs nvim"
alias gbr="git branch --show-current"
