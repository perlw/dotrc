#!/bin/zsh

handleWGT() {
  from_timestamp=0
  skip=false
  if [[ $# -ge 1 ]]; then
    case $1 in
      from)
        date=""
        if [[ $# -ge 2 ]]; then
          for i in {2..$#}; do
            date="$date ${@[i]}"
          done
          from_timestamp=`date --date "$date" +%s`
        else
          print "Err"
          skip=true
        fi
        ;;
      *)
        date=`date +%Y-%m-%d\ %H:%M`
        echo "$date #$@" >> ~/weight.md
        skip=true
        ;;
    esac
  fi

  if ! [ $skip == true ]; then
    raw=("${(@f)$(cat ~/weight.md)}")
    min=999.0
    max=0.0
    current=999.0
    start=0
    for line in $raw; do
      raw_date=`echo $line | cut -d# -f1`
      date_timestamp=`date --date "$raw_date" +%s`
      if [[ $from_timestamp -gt $date_timestamp ]]; then
        start=$(( start + 1 ))
        continue
      fi

      wgt=`print $line | cut -d# -f2`

      if [[ $wgt < $min ]]; then
        min=$wgt
      fi
      if [[ $wgt > $max ]]; then
        max=$wgt
      fi
      current=$wgt
    done

    print "Showing $min-$max, current ${current}kg"
    norm=$(( max - min ))
    last=999.0
    for ((i = $start; i < $#raw; i++)); do
      line=${raw[$(( i + 1 ))]}
      raw_date=`echo $line | cut -d# -f1`
      date_timestamp=`date --date "$raw_date" +%s`
      if [[ $from_timestamp -gt $date_timestamp ]]; then
        continue
      fi

      wgt=`print $line | cut -d# -f2`
      wgt_norm=$(( wgt - min ))
      ratio=$(( $wgt_norm / $norm ))

      color="%F{green}"
      if [[ $wgt -gt $last ]]; then
        color="%F{red}"
      fi
      char='▁'
      if [[ $ratio > $(( 7.0 / 8.0 )) ]]; then
        char='█'
      elif [[ $ratio > $(( 6.0 / 8.0 )) ]]; then
        char='▇'
      elif [[ $ratio > $(( 5.0 / 8.0 )) ]]; then
        char='▆'
      elif [[ $ratio > $(( 4.0 / 8.0 )) ]]; then
        char='▅'
      elif [[ $ratio > $(( 3.0 / 8.0 )) ]]; then
        char='▄'
      elif [[ $ratio > $(( 2.0 / 8.0 )) ]]; then
        char='▃'
      elif [[ $ratio > $(( 1.0 / 8.0 )) ]]; then
        char='▂'
      fi
      print -P -f "%b%b%b" $color $char "%f"

      last=$wgt
    done
    printf '\n'

    len=$#raw
    num=$(( len / 7 ))
    for ((i = 0; i <= $num; i++)); do
      line=${raw[$(( i + 1 ))]}
      raw_date=`print ${raw[$(( (i * 7)+1 ))]} | cut -d# -f1`
      date_timestamp=`date --date "$raw_date" +%s`
      if [[ $from_timestamp -gt $date_timestamp ]]; then
        continue
      fi

      date=`date --date "$raw_date" +%d/%m`
      printf "$date  "
    done
    printf '\n'
  fi
}
alias wgt='handleWGT'
