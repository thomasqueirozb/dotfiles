#unset -v HOME # Force bash to obtain its value for HOME from getpwent(3) on first use, so tilde-expansion is sane.

is_login() {
    if command -v shopt >/dev/null; then
        shopt -q login_shell
        return "$@"
    elif [[ -o login ]]; then
        return 0
    fi

    return 1
}

if is_login; then
    . "$HOME/.config/bash/path_env"
    if [[ -t 0 && ( $(tty) == /dev/tty1 || $(tty) == /dev/tty7 ) && ! $DISPLAY ]]; then
        # if command -v uwsm && uwsm check may-start && uwsm select; then
        if command -v uwsm >/dev/null && uwsm check may-start; then
            # exec uwsm start default
            exec uwsm start hyprland
        else
            exec startx
        fi
    fi

    # shellcheck source=/dev/null
    [ -f ~/.bashrc ] && . ~/.bashrc
fi
