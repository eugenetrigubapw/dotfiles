#!/bin/sh

BG="#1c1c1c"
FG="#d0d0d0"
FONT="Hack:size=14:style=Regular"

while true; do
  DATE=$(date "+%Y-%m-%d %H:%M")
  BAT=$(apm -l)
  LOAD=$(sysctl -n vm.loadavg | awk '{print $1" "$2" "$3}')

  echo " Load: $LOAD | Battery: $BAT% | $DATE "
  sleep 5
done | lemonbar-xft -g x24 -B "$BG" -F "$FG" -f "$FONT" &
