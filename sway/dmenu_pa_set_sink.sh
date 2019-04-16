#!/bin/zsh
sinks=$(pacmd list-sinks | awk '/index:/{i=$NF}/device.description/{print i,":",substr($0, index($0, $3)+1, length($0)-index($0, $3)-1)};')
cmd="$MENU -p sinks"
choice=$(echo $sinks | eval $cmd)
[[ ! -z $choice ]] && pacmd set-default-sink $(echo $choice | cut -d ' ' -f 1)
