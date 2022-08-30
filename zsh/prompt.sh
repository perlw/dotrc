#!/bin/zsh

vcsInfo=""
dirInfo=""
sessions=""
gcloudProjectId=""

gitInfo () {
  gitStatus=$(git status --porcelain 2>/dev/null)
  if [[ $? -ne 0 ]]; then
    vcsInfo=""
    return
  fi

  local branchName=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if (( $#branchName > 9 )); then
    # NOTE: Work fix. Long branchnames.
    branchName="${branchName:0:8}…"
  fi
  if [[ $branchName == "HEAD" ]]; then
    branchName="%B%F{red}$(git rev-parse --short HEAD 2>/dev/null)"
  else
    branchName="%B%F{green}$branchName"
  fi

  local dirtyFlag=""
  if [[ ! -z $gitStatus ]]; then
    dirtyFlag="%F{yellow}‼"
  fi

  vcsInfo=" %B%F{blue}($branchName%F{blue})%f%b$dirtyFlag%f%b"
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
  local credPath="$HOME/.config/gcloud/application_default_credentials.json"
  local id=$([ -f $credPath ] && cat $credPath | jq -r .quota_project_id)
  gcloudProjectId=$([ ! -z $id ] && echo "%B%F{blue}%f$id%b")
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
export PROMPT='($os$hostname:$directory)[$retVal$jobs$dirInfo$sessions]$vcsInfo '
export RPROMPT='$gcloudProjectId'
