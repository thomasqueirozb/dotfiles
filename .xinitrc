#!/bin/bash

# shellcheck source=/dev/null
[ -f "$HOME/.xprofile" ] && source "$HOME/.xprofile"

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# The timeout is a compromise. ymmv.
k1="Super_L=Menu"
xcape -t 667 -e "$k1"

xinput set-prop 'ELN4690:00 04F3:304B Touchpad' 'libinput Tapping Enabled' 1
xinput set-prop 'ELN4690:00 04F3:304B Touchpad' 'libinput Disable While Typing Enabled' 0
xinput set-prop 'ELN4690:00 04F3:304B Touchpad' 'libinput Natural Scrolling Enabled' 1

# Disable middle click emulation
# xinput set-prop "ELN4690:00 04F3:304B Touchpad" "libinput Middle Emulation Enabled" 1


setxkbmap -layout "us,us" -variant "basic,intl" -option grp:shifts_toggle

export userresources="$HOME/.Xresources"
export usermodmap="$HOME/.Xmodmap"
export sysresources="/etc/X11/xinit/.Xresources"
export sysmodmap="/etc/X11/xinit/.Xmodmap"

[ -f "$userresources" ] && xrdb -merge "$userresources"
[ -f "$usermodmap" ]    && xmodmap "$usermodmap"
[ -f "$sysresources" ]  && xrdb -merge "$sysresources"
[ -f "$sysmodmap" ]     && xmodmap "$sysmodmap"


if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        # shellcheck source=/dev/null
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

exec i3
# exec dwm
