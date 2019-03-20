#!/bin/zsh
# TODO: Add from path
files=("${(f)$(ls /usr/share/applications/*.desktop)}")
names=""
typeset -A execs
for file in $files; do
  name=$(cat $file | grep -m 1 ^Name= | cut -d = -f 2)
  if [[ -z $names ]]; then
    names="$name"
  else
    names="$names\n$name"
  fi
  execs[$name]=$(cat $file | grep -m 1 ^Exec= | cut -d = -f 2 | cut -d ' ' -f 1)
done
choice=$(echo -e $names | bemenu -i "$@")
echo ${execs[$choice]} | ${SHELL:-"/bin/sh"} &
