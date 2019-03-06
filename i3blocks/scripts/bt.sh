#!/usr/bin/env bash
bt_id=$1
btinfo=$(bluetoothctl <<EOF
info $bt_id
EOF
)
connected=$(echo "$btinfo" | grep "Connected" | cut -d  ":" -f 2 | tr -d '[:space:]')
if [[ $connected == "yes" ]]; then
  echo "🎧"
fi
