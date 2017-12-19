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

# Arch
aurDownload() {
  if [[ ! -d Source/$1 ]]; then
    print -P '%F{cyan}Downloading...%f'
    cd ~/Source
    git clone https://aur.archlinux.org/$1.git
    if [[ $? -eq 0 ]]; then
      print -P '%F{green}Downloaded!%f'
    else
      print -P '%F{red}Something went wrong...%f'
      exit 1
    fi
  else
    print -P '%F{green}Found!%f'
  fi
}

aurInstall() {
  aurDownload $1

  cd ~/Source/$1
  print -P '%F{cyan}Installing...%f'
  makepkg -si
  print -P '%F{cyan}Done...%f'
}

aurUpdate() {
  if [[ ! -d Source/$1 ]]; then
    print -P '%F{red}Not found...%f'
    exit -1
  fi

  print -P '%F{cyan}Updating...%f'
  cd ~/Source/$1
  git pull
  makepkg -si
  if [[ $? -eq 0 ]]; then
    print -P '%F{green}Done!%f'
  else
    print -P '%F{red}Something went wrong...%f'
    exit 1
  fi
}

# TODO: Support for multiple repos
handleAur() {
  (
    if [[ $# -gt 1 ]]; then
      case $1 in
        download)
          aurDownload $2
          ;;
        install)
          aurInstall $2
          ;;
        update)
          aurUpdate $2
          ;;
        *)
          print -P '%F{red}$0 (download|install|update) reponame%f'
          ;;
      esac
    else
      print -P '$0 (download|install|update) reponame'
    fi
  )
}
alias aur='handleAur'

# Personal
## Configs
alias ez="nvim ~/.zshrc"
alias sz="source ~/.zshrc"
alias ei="nvim ~/.config/i3/config"
alias er="nvim ~/.config/ranger/rc.conf"
alias et="nvim ~/.config/termite/config"
alias ezt="nvim ~/.oh-my-zsh/themes/perlw.zsh-theme"
alias ev="nvim ~/.config/nvim/init.vim"

# TODO
handleTodo() {
  if [[ $# -ge 1 ]]; then
    echo "* $@" >> ~/TODO.md
  else
    cat ~/TODO.md
  fi
}
alias todo='handleTodo'

# WGT
handleWGT() {
  from_timestamp=0
  skip=false
  if [[ $# -ge 1 ]]; then
    case $1 in
      from)
        date=""
        if [[ $# -ge 2 ]]; then
          for i in {2..$#}; do
            date="$date ${@[i]}"
          done
          from_timestamp=`date --date "$date" +%s`
        else
          print "Err"
          skip=true
        fi
        ;;
      *)
        date=`date +%Y-%m-%d\ %H:%M`
        echo "$date #$@" >> ~/weight.md
        skip=true
        ;;
    esac
  fi

  if ! [ $skip == true ]; then
    raw=("${(@f)$(cat ~/weight.md)}")
    min=999.0
    max=0.0
    current=999.0
    start=0
    for line in $raw; do
      raw_date=`echo $line | cut -d# -f1`
      date_timestamp=`date --date "$raw_date" +%s`
      if [[ $from_timestamp -gt $date_timestamp ]]; then
        start=$(( start + 1 ))
        continue
      fi

      wgt=`print $line | cut -d# -f2`

      if [[ $wgt < $min ]]; then
        min=$wgt
      fi
      if [[ $wgt > $max ]]; then
        max=$wgt
      fi
      current=$wgt
    done

    print "Showing $min-$max, current ${current}kg"
    norm=$(( max - min ))
    last=999.0
    for ((i = $start; i < $#raw; i++)); do
      line=${raw[$(( i + 1 ))]}
      raw_date=`echo $line | cut -d# -f1`
      date_timestamp=`date --date "$raw_date" +%s`
      if [[ $from_timestamp -gt $date_timestamp ]]; then
        continue
      fi

      wgt=`print $line | cut -d# -f2`
      wgt_norm=$(( wgt - min ))
      ratio=$(( $wgt_norm / $norm ))

      color="%F{green}"
      if [[ $wgt -gt $last ]]; then
        color="%F{red}"
      fi
      char='▁'
      if [[ $ratio > $(( 7.0 / 8.0 )) ]]; then
        char='█'
      elif [[ $ratio > $(( 6.0 / 8.0 )) ]]; then
        char='▇'
      elif [[ $ratio > $(( 5.0 / 8.0 )) ]]; then
        char='▆'
      elif [[ $ratio > $(( 4.0 / 8.0 )) ]]; then
        char='▅'
      elif [[ $ratio > $(( 3.0 / 8.0 )) ]]; then
        char='▄'
      elif [[ $ratio > $(( 2.0 / 8.0 )) ]]; then
        char='▃'
      elif [[ $ratio > $(( 1.0 / 8.0 )) ]]; then
        char='▂'
      fi
      print -P -f "%b%b%b" $color $char "%f"

      last=$wgt
    done
    printf '\n'

    len=$#raw
    num=$(( len / 7 ))
    for ((i = 0; i <= $num; i++)); do
      line=${raw[$(( i + 1 ))]}
      raw_date=`print ${raw[$(( (i * 7)+1 ))]} | cut -d# -f1`
      date_timestamp=`date --date "$raw_date" +%s`
      if [[ $from_timestamp -gt $date_timestamp ]]; then
        continue
      fi

      date=`date --date "$raw_date" +%d/%m`
      printf "$date  "
    done
    printf '\n'
  fi
}
alias wgt='handleWGT'

## Passwords
#alias op="~/op get item \"Lab5 SSH\" | jq '.details.fields[] | select(.designation == \"password\").value' | sed 's/\"\\(.*\\)\"/\\1/'"

## Navigation
alias gd="cd ~/Downloads"
alias gc="cd ~/.config"
alias gi="cd ~/.config/i3"

### Projects
alias gp="cd ~/Projects"
alias gpo="cd ~/Projects/office"
alias gpd="cd ~/Projects/darkhub"
alias gps="cd ~/Projects/sandbox_rust"

# Work
## Configs
alias eh="nvim ~/Work/Homestead/Homestead.yaml"

## Vagrant
alias vu="(cd ~/Work/Homestead; vagrant up)"
alias vd="(cd ~/Work/Homestead; vagrant halt)"

## Consul
alias ca="(cd ~/Work/consul; consul agent -server -data-dir . -bootstrap -advertise 127.0.0.1 -rejoin -ui)"
alias cg="cgateway proxy --omit jobinternalreport --omit apiproxy-80"

## Navigation
alias gg="cd ~/go"
alias gw="cd ~/Work"
alias gwa="cd ~/Work/api"
alias gwh="cd ~/Work/Homestead"
alias gwc="cd ~/Work/customerservice"
alias gwe="cd ~/Work/eshu"
