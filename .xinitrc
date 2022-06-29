#!/bin/bash

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# The timeout is a compromise. ymmv.
xcape -t 667 -e "Super_L=Menu"

hn="$(hostname)"
if [ "$hn" = "thomas-laptop" ]; then
    xinput set-prop 'ELN4690:00 04F3:304B Touchpad' 'libinput Tapping Enabled' 1
    xinput set-prop 'ELN4690:00 04F3:304B Touchpad' 'libinput Disable While Typing Enabled' 0
    xinput set-prop 'ELN4690:00 04F3:304B Touchpad' 'libinput Natural Scrolling Enabled' 1

    # Disable middle click emulation
    # xinput set-prop "ELN4690:00 04F3:304B Touchpad" "libinput Middle Emulation Enabled" 1
elif [ "$hn" = "thomas-inspiron" ]; then
    xinput set-prop 'DELL0A78:00 27C6:0D42 Touchpad' 'libinput Tapping Enabled' 1
    xinput set-prop 'DELL0A78:00 27C6:0D42 Touchpad' 'libinput Natural Scrolling Enabled' 1

    numlockx &
else
    numlockx &
fi


setxkbmap -layout "us,us" -variant "basic,intl" -option grp:shifts_toggle
xmodmap -e "keysym Scroll_Lock = Multi_key"

# export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XENVIRONMENT="$XDG_CONFIG_HOME/X11/xdefaults"

export userresources="$XDG_CONFIG_HOME/X11/xresources"
export usermodmap="$XDG_CONFIG_HOME/X11/xmodmap"
export sysresources="/etc/X11/xinit/.Xresources"
export sysmodmap="/etc/X11/xinit/.Xmodmap"

[ -f "$XENVIRONMENT" ]  && xrdb -merge "$XENVIRONMENT"
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

export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_PLATFORMTHEME="qt5ct"
export QT_PLATFORMPLUGIN="qt5ct"


if [ "$(hostname)" = "thomas-pc" ]; then
    export LIBVA_DRIVER_NAME=vdpau
    export VDPAU_DRIVER=nvidia
fi

exec i3
# exec dwm
