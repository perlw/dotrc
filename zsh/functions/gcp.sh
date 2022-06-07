#!/bin/zsh

GCPstreamTopBuild() {
  gcloud beta builds log --stream `gcp-builds-id`
}

alias gcp-builds="gcloud beta builds list --ongoing"
alias gcp-builds-id="gcloud beta builds list --ongoing | cut -d ' ' -f 1 | tail -n 1"
alias gcp-stream-build="GCPstreamTopBuild"
