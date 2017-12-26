#!/bin/zsh

# Passwords
#alias op="~/op get item \"Lab5 SSH\" | jq '.details.fields[] | select(.designation == \"password\").value' | sed 's/\"\\(.*\\)\"/\\1/'"

# Configs
alias eh="nvim ~/Work/Homestead/Homestead.yaml"

# Vagrant
alias vu="(cd ~/Work/Homestead; vagrant up)"
alias vd="(cd ~/Work/Homestead; vagrant halt)"

# Consul
alias ca="(cd ~/Work/consul; consul agent -server -data-dir . -bootstrap -advertise 127.0.0.1 -rejoin -ui)"
alias cg="cgateway proxy --omit jobinternalreport --omit apiproxy-80"

# Navigation
alias gg="cd ~/go"
alias gw="cd ~/Work"
alias gwa="cd ~/Work/api"
alias gwh="cd ~/Work/Homestead"
alias gwc="cd ~/Work/customerservice"
alias gwe="cd ~/Work/eshu"
alias ggs="cd $GOPATH/src/github.com/Sydsvenskan"
