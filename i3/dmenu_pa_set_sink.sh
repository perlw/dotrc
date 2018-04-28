#!/bin/zsh
sinks=$(pacmd list-sinks | awk '/index:/{i=$NF}/device.description/{print i,":",substr($0, index($0, $3)+1, length($0)-index($0, $3)-1)};')
choice=$(echo $sinks | dmenu -i -p "Sinks")
[[ ! -z $choice ]] && pacmd set-default-sink $(echo $choice | cut -d ' ' -f 1)
