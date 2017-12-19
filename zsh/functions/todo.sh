#!/bin/zsh

handleTodo() {
  if [[ $# -ge 1 ]]; then
    echo "* $@" >> ~/TODO.md
  else
    cat ~/TODO.md
  fi
}
alias todo='handleTodo'
