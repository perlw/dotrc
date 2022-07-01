#!/bin/zsh

vcsInfo=""
dirInfo=""
sessions=""

gitInfo () {
  gitStatus=$(git status --porcelain 2>/dev/null)
  if [[ $? -ne 0 ]]; then
    vcsInfo=""
    return
  fi

  local branchName=$(git symbolic-ref HEAD 2>/dev/null | cut -d '/' -f 3)
  if [[ -z $branchName ]]; then
    branchName="detached"
  fi

  local isDirty=0
  if [[ ! -z $gitStatus ]]; then
    isDirty=1
  fi

  local branchP="%B%F{red}$branchName%f%b"
  local dirtyP=""
  if [[ $isDirty -ne 0 ]]; then
    dirtyP="%F{yellow}‼%f"
  fi
  vcsInfo=" %B%F{blue}($branchP%F{blue})%f%b$dirtyP"
}

dirCount() {
  count="$(dirs -p | wc -l | tr -d ' ')"
  dirInfo=$([[ $count -gt 1 ]] && echo " $count")
}

tmuxSessionCount() {
  count="$(tmux list-sessions -F \#{session_name} 2>/dev/null | wc -l)"
  sessions=$([[ $count -gt 1 ]] && echo " %B%F{cyan}$count%f%b")
}

if [[ ! -v PROMPT_COLOR ]]; then
  PROMPT_COLOR="blue"
fi

hostname="%B%F{$PROMPT_COLOR}%m%f%b"
directory="%F{cyan}%1~%f"
retVal="%(?:%B%F{green}✓:%B%F{red}!%?)%f%b"
jobs="%(1j: %B%F{yellow}%j:)%f%b"

os=''
un=`uname`
if [ $un = 'Linux' ]; then
  os=''
else
  if [ $un = 'Darwin' ]; then
    os=''
  fi
fi

precmd_functions=( _z_precmd )
precmd_functions+=( gitInfo dirCount tmuxSessionCount )
setopt prompt_subst
export PROMPT='($os$hostname:$directory)[$retVal$jobs$dirInfo$sessions]$vcsInfo '
