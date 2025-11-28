#!/bin/sh
set -e
export MOZ_ACCELERATED=1
export MOZ_WEBRENDER=1
xrdb -merge ~/.Xresources
setxkbmap -option caps:ctrl_modifier
~/.fehbg &
~/.config/lemonbar-xft/bar.sh | lemonbar-xft -f "Hack:size=14" -g x24 -B "#1c1c1c" -F "#d0d0d0" &
~/.local/bin/sct-daemon &
exec cwm
