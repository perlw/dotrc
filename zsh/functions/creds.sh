#!/bin/zsh

genCreds() {
  id=$(od -vN 16 -An -tx1 /dev/urandom | tr -d " \n"; echo)
  secret=$(od -vN 16 -An -tx1 /dev/urandom | tr -d " \n"; echo)
  echo "{\"id\":\"${id}\",\"secret\":\"${secret}\"}"
}

jwtDec() {
  echo "Header:"
  echo $1 | cut -d "." -f 1 | base64 -i --decode | jq .
  echo "Payload:"
  echo $1 | cut -d "." -f 2 | base64 -i --decode | jq .
}

alias gen-creds='genCreds'
alias jwt-dec='jwtDec'
