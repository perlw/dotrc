#!/bin/zsh

gitInfo=""
dirInfo=""
sessions=""
gcloudProjectId=""

gitInfo () {
  gitStatus=$(git status --porcelain 2>/dev/null)
  if [[ $? -ne 0 ]]; then
    vcsInfo=""
    return
  fi

  local branchColor="white"
  local branchName=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [[ $branchName != "master" && $branchName != "main" && $branchName != "trunk" ]]; then
    branchColor="yellow"
  elif [[ $branchName == "HEAD" ]]; then
    branchColor="red"
  fi

  local dirtyFlag=""
  if [[ ! -z $gitStatus ]]; then
    dirtyFlag="%F{yellow}‼%f"
  fi

  gitInfo="%B%F{$branchColor}%f%b$dirtyFlag"
}

dirCount() {
  local count="$(dirs -p | wc -l | tr -d ' ')"
  dirInfo=$([[ $count -gt 1 ]] && echo " $count")
}

tmuxSessionCount() {
  local count="$(tmux list-sessions -F \#{session_name} 2>/dev/null | wc -l)"
  sessions=$([[ $count -gt 0 ]] && echo " %B%F{cyan}$count%f%b")
}

gcloudProject() {
  if [[ $PWD =~ 'Work' ]]; then
    local credPath="$HOME/.config/gcloud/application_default_credentials.json"
    local id=$([ -f $credPath ] && cat $credPath | jq -r .quota_project_id)
    gcloudProjectId=$([ ! -z $id ] && echo "%B%F{blue}%f$id%b")
  else
    gcloudProjectId=""
  fi
}

if [[ ! -v PROMPT_COLOR ]]; then
  PROMPT_COLOR="blue"
fi

hostname="%B%F{$PROMPT_COLOR}%m%f%b"
directory="%F{cyan}%1~%f"
retVal="%(?:%B%F{green}✓:%B%F{red}✖%?)%f%b"
jobs="%(1j: %B%F{yellow}%j:)%f%b"

os=''
un=`uname -sr`
if [[ $un =~ 'Linux' ]]; then
  if [[ $un =~ 'arch' ]]; then # ;D
    os=''
  else
    os=''
  fi
elif [[ $un =~ 'BSD' ]]; then
  os=''
elif [[ $un =~ 'Darwin' ]]; then
  os=''
fi

precmd_functions=( _z_precmd )
precmd_functions+=( gitInfo dirCount tmuxSessionCount gcloudProject )
setopt prompt_subst
export PROMPT='($os$hostname:$directory)[$retVal$jobs$dirInfo$sessions]$gitInfo '
export RPROMPT='$gcloudProjectId'
