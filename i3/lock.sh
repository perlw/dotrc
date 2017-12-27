#!/bin/zsh
device=/dev/input/ckb1/cmd
if [ -e $device ]; then
  echo "rgb lock:800000" > $device
fi

scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -blur 0x2 -brightness-contrast -25x-25 -scale 1000% /tmp/screen.png

## Adds lock icon to center of each connected screen
#MAXRES=`xrandr -q | grep \ current | sed -r "s/^.*current\s([0-9]+\sx\s[0-9]+),.*$/\1/"`
#MAXRESX=`echo $MAXRES | cut -d\  -f1`
#MAXRESY=`echo $MAXRES | cut -d\  -f3`
LOCKX=128
LOCKY=128

SCREENS=("${(f)$(xrandr -q | grep \ connected)}")
for LINE in $SCREENS; do
  #SCREEN=`echo $LINE | cut -d\  -f1`
  RES=`echo $LINE | sed -r "s/.*\s([0-9]+x[0-9]+).*/\1/g"`
  RESX=`echo $RES | cut -dx -f1`
  RESY=`echo $RES | cut -dx -f2`
  OFF=`echo $LINE | sed -r "s/.*\+([0-9]+\+[0-9]).*/\1/g"`
  OFFX=`echo $OFF | cut -d+ -f1`
  OFFY=`echo $OFF | cut -d+ -f2`

  GEOM=''
  GEOM="+$(((RESX / 2) + OFFX - (LOCKX / 2)))"
  GEOM="$GEOM+$(((RESY / 2) + OFFY - (LOCKY / 2)))"

  convert /tmp/screen.png ~/.config/i3/lock.png -geometry $GEOM -composite -matte /tmp/screen.png
done

xset s 60 60
xset dpms 60 60 60
i3lock -n -u -e -i /tmp/screen.png
xset s 600 600
xset dpms 600 600 600

if [ -e $device ]; then
  echo "rgb lock:008000" > $device
fi
