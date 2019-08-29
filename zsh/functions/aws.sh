#!/bin/zsh

setupAWSEnv() {
  export AWS_KEY=`aws configure get default.aws_access_key_id`
  export AWS_SECRET=`aws configure get default.aws_secret_access_key`
  export AWS_REGION=eu-west-1
}

AWSkick() {
  err=0
  if [[ $# -gt 0 ]]; then
    args=("${(s:/:)1}")
    if [[ $#args -gt 1 ]]; then
      aws ecs update-service --cluster $args[1] --service $args[2] --force-new-deployment
      err=$?
    else
      err=1
    fi
  else
    err=1
  fi

  if [[ $err -eq 0 ]]; then
    print -P '%F{green}Done!%f'
  else
    print -P '$0 <cluster>/<service>'
  fi
}

AWSstate() {
  err=0
  if [[ $# -gt 0 ]]; then
    args=("${(s:/:)1}")
    if [[ $#args -gt 1 ]]; then
      aws ecs describe-services --cluster $args[1] --services $args[2] | jq -r .services[].events[0].message
      err=$?
    else
      err=1
    fi
  else
    err=1
  fi

  if [[ $err -eq 1 ]]; then
    print -P '$0 <cluster>/<service>'
  fi
}

AWStaskenv() {
  err=0
  if [[ $# -gt 0 ]]; then
    args=("${(s:/:)1}")
    if [[ $#args -gt 1 ]]; then
			aws ecs describe-services --cluster $args[1] --service $args[2] | jq -r .services[].taskDefinition | xargs -I {} aws ecs describe-task-definition --task-definition {} | jq .taskDefinition.containerDefinitions[].environment
      err=$?
    else
      err=1
    fi
  else
    err=1
  fi

  if [[ $err -eq 1 ]]; then
    print -P '$0 <cluster>/<service>'
  fi
}

AWSpipe() {
  if [[ $# -gt 1 ]]; then
    case $2 in
      approve)
        aws codepipeline get-pipeline-state --name $1 --query "stageStates[*].actionStates[*].latestExecution.token" \
          --output text | xargs -I {} aws codepipeline put-approval-result --pipeline-name schedmail-prod \
          --stage-name Deploy --action-name ApproveChangeSet --result summary=auto,status=Approved --token {}
        if [[ $? -ne 0 ]]; then
          print -P '%F{red}could not approve%f'
          return -1
        fi
        ;;
      reject)
        aws codepipeline get-pipeline-state --name $1 --query "stageStates[*].actionStates[*].latestExecution.token" \
          --output text | xargs -I {} aws codepipeline put-approval-result --pipeline-name schedmail-prod \
          --stage-name Deploy --action-name ApproveChangeSet --result summary=auto,status=Rejected --token {}
        if [[ $? -ne 0 ]]; then
          print -P '%F{red}could not reject%f'
          return -1
        fi
        ;;
      *)
        print -P '$0 <pipeline> [approve|reject]'
        ;;
        esac
  elif [[ $# -gt 0 ]]; then
    DATA=$(aws codepipeline get-pipeline-state --name $1 --query "stageStates[*].{name: stageName, states: actionStates[*].{name: actionName, status: latestExecution.status, summary: latestExecution.summary, revisionURL: revisionURL, lastStatusChange: latestExecution.lastStatusChange, externalExecutionUrl: latestExecution.externalExecutionUrl}}")
    if [[ $? -ne 0 ]]; then
      print -P '%F{red}no such pipe%f'
      return -1
    fi

    echo $1
    echo "https://eu-west-1.console.aws.amazon.com/codesuite/codepipeline/pipelines/$1/view"
    echo "╥"
    STAGES=$(echo -E $DATA | sed 's/\\n/ /g' | sed 's/\\\"//g' | jq -cr ".[]")
    CURR_STAGE=$(echo -E $DATA | jq -cr ". | length")
    echo -E $STAGES | while read STAGE; do
      CURR_STAGE=$((CURR_STAGE - 1))

      STAGENAME=$(echo $STAGE | jq -r ".name")
      print -P "╟┬%F{blue}$STAGENAME%f"
      STATES=$(echo -E $STAGE | jq -cr ".states[]")
      CURR_STATE=$(echo -E $STAGE | jq -cr ".states | length")
      echo -E $STATES | while read STATE; do
        CURR_STATE=$((CURR_STATE - 1))

        NAME=$(echo $STATE | jq -r ".name")
        STATUS=$(echo $STATE | jq -r ".status")
        SUMMARY=$(echo $STATE | jq -r ".summary")
        REVISION=$(echo $STATE | jq -r ".revisionUrl")
        TIMESTAMP=$(echo $STATE | jq -r ".lastStatusChange")

        COL_CHAR=""
        if [[ CURR_STATE -ne 0 ]]; then
          OUTPUT="║├┬$NAME ➡"
          COL_CHAR="│"
        else
          OUTPUT="║└┬$NAME ➡"
          COL_CHAR=" "
        fi
        case $STATUS in
          Succeeded)
            OUTPUT="$OUTPUT %F{green}$STATUS%f"
            ;;
          InProgress)
            OUTPUT="$OUTPUT %F{yellow}$STATUS%f"
            ;;
          Failed)
            OUTPUT="$OUTPUT %F{red}$STATUS%f"
            ERRURL=$(echo $STATE | jq -r ".externalExecutionUrl")
            OUTPUT="$OUTPUT\n║$COL_CHAR├$ERRURL"
            ;;
          *)
            OUTPUT="$OUTPUT %F{red}$STATUS%f"
            ;;
        esac
        if [ $SUMMARY != "null" ]; then
          OUTPUT="$OUTPUT\n║$COL_CHAR├$SUMMARY"
        fi
        if [ $REVISION != "null" ]; then
          OUTPUT="$OUTPUT\n║$COL_CHAR├$REVISION"
        fi
        if [ $TIMESTAMP != "null" ]; then
          OUTPUT="$OUTPUT\n║$COL_CHAR└$(date -d @$TIMESTAMP)"
        fi

        print -P "$OUTPUT"
        if [[ CURR_STATE -ne 0 ]]; then
          print -P "║$COL_CHAR"
        fi
        if [[ CURR_STAGE -ne 0 ]]; then
          print -P "║$COL_CHAR"
        fi
      done
    done
    print -P "╨\n"
  else
    print -P '$0 <pipeline> [approve|reject]'
  fi
}

alias aws-env='setupAWSEnv'
alias aws-kick='AWSkick'
alias aws-state='AWSstate'
alias aws-task-env='AWStaskenv'
alias aws-pipe='AWSpipe'
