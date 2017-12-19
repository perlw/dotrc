#!/bin/zsh

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
