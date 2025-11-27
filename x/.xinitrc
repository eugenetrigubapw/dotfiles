#!/bin/sh
set -e
export MOZ_ACCELERATED=1
export MOZ_WEBRENDER=1
setxkbmap -option caps:ctrl_modifier
feh --bg-fill ~/Pictures/Wallpapers/3840x2160-dark-openbsd.png
~/.config/lemonbar-xft/bar.sh &
# xrandr --output DP-1 --primary --mode 3840x2160 --output DP-2 --mode 3840x2160 --right-of DP-2
xrdb -merge ~/.Xresources
exec cwm
