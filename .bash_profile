#unset -v HOME # Force bash to obtain its value for HOME from getpwent(3) on first use, so tilde-expansion is sane.


if shopt -q login_shell; then
    export TERM=xterm
    . "$HOME/.bash/path_env"
    if [[ -t 0 && $(tty) == /dev/tty1 && ! $DISPLAY ]]; then
        # shellcheck source=/dev/null
        . "$HOME/.xprofile"
        exec startx
    fi

    # shellcheck source=/dev/null
    [ -f ~/.bashrc ] && source ~/.bashrc
fi
