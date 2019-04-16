#!/bin/zsh

awsGo() {
  awsURL="https://eu-west-1.console.aws.amazon.com/$1/home?region=eu-west-1#$2"
  firefox -new-tab $awsURL
}

services='cp\ncf\ncw\net\ns3\nssm'
cmd="$MENU -p AWS"
choice=$(echo $services | eval $cmd)
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
    ssm)
      awsGo 'ec2/v2' 'Parameters:sort=Name'
      ;;
  esac
fi
