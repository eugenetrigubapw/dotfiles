#!/bin/sh
set -e
# xrandr --output DP-1 --primary --mode 3840x2160 --output DP-2 --mode 3840x2160 --right-of DP-2
xrdb -merge ~/.Xresources
exec cwm
