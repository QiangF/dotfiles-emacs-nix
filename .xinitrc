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

WM=awesome

# Fix IntelliJ
export _JAVA_AWT_WM_NONREPARENTING=1

# Fix DPI Scaling
export QT_AUTO_SCREEN_SCALE_FACTOR=0
#$HOME/sh/displays.sh
xsetroot -cursor_name left_ptr &
picom --experimental-backends &
dunst &
[ -z "$(pgrep mpd)" ] && mpd ; mpc load di.fm.pls && mpc repeat on && mpc play &

case ${WM} in
    awesome)
        sh $HOME/sh/x.sh
        exec awesome
    ;;

	bspwm)
		sxhkd &
		sh $HOME/.config/polybar/launch.sh &
		exec bspwm
	;;

	dwm)
		nitrogen --restore
        sh $HOME/sh/x.sh
		while true; do
			# Log stderror to a file
			sh $HOME/code/git/dwm-bar/dwm_bar.sh &
			dwm 2> ~/.dwm.log
			# No error logging
			#dwm >/dev/null 2>&1
		done
    ;;

	xmonad)
        # Log stderror to a file
        xmonad 2>> ~/.xmonad.log
        # No error logging
        #dwm >/dev/null 2>&1
    ;;

esac
