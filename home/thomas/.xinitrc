#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

export XENVIRONMENT=${HOME}/.Xresources

export VDPAU_DRIVER=nvidia
export QT_QPA_PLATFORMTHEME="qt5ct"

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# The timeout is a compromise. ymmv.
k1='Super_L=Menu'
xcape -t 667 -e "$k1"

setxkbmap br
exec i3
# exec dwm
# # merge in defaults and keymaps
# 
# if [ -f $sysresources ]; then
#     xrdb -merge $sysresources
# 
# fi
# 
# if [ -f $sysmodmap ]; then
#     xmodmap $sysmodmap
# fi
# 
# if [ -f "$userresources" ]; then
# 
# 
# 
# 
# 
# 
# 
#     xrdb -merge "$userresources"
# 
# fi
# 
# if [ -f "$usermodmap" ]; then
#     xmodmap "$usermodmap"
# fi
# 
# # start some nice programs
# 
# if [ -d /etc/X11/xinit/xinitrc.d ] ; then
#  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
#   [ -x "$f" ] && . "$f"
#  done
#  unset f
# fi
# 
# twm &
# xclock -geometry 50x50-1+1 &
# xterm -geometry 80x50+494+51 &
# xterm -geometry 80x20+494-0 &
# exec xterm -geometry 80x66+0+0 -name login
