#!/bin/zsh

genCreds() {
  id=$(od -vN 16 -An -tx1 /dev/urandom | tr -d " \n"; echo)
  secret=$(od -vN 16 -An -tx1 /dev/urandom | tr -d " \n"; echo)
  echo "{\"id\":\"${id}\",\"secret\":\"${secret}\"}"
}
alias gen-creds='genCreds'
