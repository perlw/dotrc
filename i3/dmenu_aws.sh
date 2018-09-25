#!/bin/zsh

awsGo() {
  awsURL="https://eu-west-1.console.aws.amazon.com/$1/home?region=eu-west-1"
  firefox -new-tab $awsURL
}

services='cp\ncf\ncw\net\ns3'
choice=$(echo $services | dmenu -i -p "AWS")
if [[ ! -z $choice ]]; then
  case $choice in
    cp)
      awsGo 'codepipeline'
      ;;
    cf)
      awsGo 'cloudformation'
      ;;
    cw)
      awsGo 'cloudwatch'
      ;;
    et)
      awsGo 'elastictranscoder'
      ;;
    s3)
      awsGo 's3'
      ;;
  esac
fi
