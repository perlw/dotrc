#!/bin/zsh

vcsinfo=""

gitinfo () {
  gitStatus=$(git status --porcelain 2>/dev/null)
  if [[ $? -ne 0 ]]; then
    vcsinfo=""
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
  vcsinfo="%B%F{blue}($branchP%F{blue})%f%b$dirtyP "
}

if [[ ! -v PROMPT_COLOR ]]; then
  PROMPT_COLOR="blue"
fi

hostname="%B%F{$PROMPT_COLOR}%m%f%b"
directory="%F{cyan}%1~%f"
retval="%(?::%B%F{red})%?%f%b"
jobs="%j"

precmd_functions=( _z_precmd )
precmd_functions+=( gitinfo )
setopt prompt_subst
export PROMPT='($hostname:$directory)[$retval $jobs] $vcsinfo'
