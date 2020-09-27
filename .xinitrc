#!/bin/sh

### Default ###

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

[ -f $sysresources ] && xrdb -merge $sysresources
[ -f $sysmodmap ] && xmodmap $sysmodmap
[ -f "$userresources" ] && xrdb -merge "$userresources"
[ -f "$usermodmap" ] && xmodmap "$usermodmap"

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

### MINE ####

WM=dwm

# Fix IntelliJ
export _JAVA_AWT_WM_NONREPARENTING=1

# Fix DPI Scaling
export QT_AUTO_SCREEN_SCALE_FACTOR=0
emacs --daemon &
$HOME/sh/displays.sh
nitrogen --restore
xsetroot -cursor_name left_ptr &
xrdb $HOME/.Xresources
picom &
dunst &
mpd ; mpc load di.fm.pls &

case ${WM} in
	bspwm)
		sxhkd &
		sh $HOME/.config/polybar/launch.sh &
		exec bspwm
	;;
	dwm)
		while true; do
			# Log stderror to a file 
			dwm 2> ~/.dwm.log
			# No error logging
			#dwm >/dev/null 2>&1
		done
		;;
esac
