#!/bin/zsh

alias gcp-builds="gcloud builds list --ongoing"
alias gcp-builds-id="gcloud builds list --ongoing | cut -d ' ' -f 1 | tail -n 1"
# alias gcp-stream-build="gcloud builds log --stream `gcp-builds-id`"
