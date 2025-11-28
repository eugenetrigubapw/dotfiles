#!/bin/sh
set -e
export MOZ_ACCELERATED=1
export MOZ_WEBRENDER=1
xrdb -merge ~/.Xresources
setxkbmap -option caps:ctrl_modifier
# xrandr --output DP-1 --primary --mode 3840x2160 --output DP-2 --mode 3840x2160 --right-of DP-2
feh --bg-fill ~/Pictures/Wallpapers/fog.jpg
~/.config/lemonbar-xft/bar.sh | lemonbar-xft -f "Hack:size=14" -g x24 -B "#1c1c1c" -F "#d0d0d0" &
exec cwm
