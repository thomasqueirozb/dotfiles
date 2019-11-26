#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

export EDITOR=nvim
export XENVIRONMENT=${HOME}/.Xresources

export QT_QPA_PLATFORMTHEME="qt5ct"
export LIBVA_DRIVER_NAME=radeonsi
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# The timeout is a compromise. ymmv.
k1='Super_L=Menu'
xcape -t 667 -e "$k1"

if [ -f ~/.xsessionrc ]; then
    source ~/.xsessionrc
fi
xinput set-prop 'ELN4690:00 04F3:304B Touchpad' 'libinput Tapping Enabled' 1
xinput set-prop 'ELN4690:00 04F3:304B Touchpad' 'libinput Disable While Typing Enabled' 0
xinput set-prop 'ELN4690:00 04F3:304B Touchpad' 'libinput Natural Scrolling Enabled' 1


setxkbmap -layout "us,us" -variant "basic,intl" -option grp:shifts_toggle

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
