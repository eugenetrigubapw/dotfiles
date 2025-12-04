#!/bin/sh
set -e

main() {
	export MOZ_ACCELERATED=1
	export MOZ_WEBRENDER=1

	xrdb -merge ~/.Xresources
	setxkbmap -option caps:ctrl_modifier
	setxkbmap -option altwin:swap_lalt_lwin
	xinput set-prop /dev/wsmouse "Device Accel Constant Deceleration" 1.0

	~/.fehbg &
	start_lemonbar
	~/.local/bin/sct-daemon &

	exec cwm
}

start_lemonbar() {
	_lemonbar_fontsize="10"
	_lemonbar_width="48"
	if is_laptop; then
		_lemonbar_fontsize="12"
		_lemonbar_width="24"
	fi
	~/.config/lemonbar-xft/bar.sh |
		lemonbar-xft \
			-f "Hack:size=${_lemonbar_fontsize}" \
			-g x${_lemonbar_width} \
			-B "#1c1c1c" -F "#d0d0d0" &
}

is_laptop() {
	[ "$(hostname -s)" = "openbsd-laptop" ]
}

main
