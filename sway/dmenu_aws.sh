#!/bin/zsh

function codepipeline() {
}

function cloudformation() {
  awsGo 'cloudformation'
}

function cloudwatch() {
  awsGo 'cloudwatch'
}

function elastictranscoder() {
  awsGo 'elastictranscoder'
}

function s3() {
  awsGo 's3'
}

function ssm() {
  awsGo 'systems-manager/parameters'
}

typeset -A aws
aws=(
  cp codepipeline
  cf cloudformation
  cw cloudwatch
  et elastictranscoder
  s3 s3
  ssm ssm
)

awsGo() {
  awsURL="https://eu-west-1.console.aws.amazon.com/$1/home?region=eu-west-1#$2"
  firefox -new-tab $awsURL
}

services=''
for k in "${(@k)aws}"; do
  services="$services$k\n"
done
cmd="$MENU -p AWS"
choice=$(echo $services | eval $cmd)
${aws[$choice]}
