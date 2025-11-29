# $OpenBSD: dot.profile,v 1.8 2022/08/10 07:40:37 tb Exp $
#
# sh/ksh initialization

PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin
export PATH HOME TERM

# Auto-start X on first console
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/ttyC0" ]; then
    startx
fi
