# if [ -o interactive ] && [ -f ~/.bashrc ]; then
# if [ -o interactive ]; then
#     LC_ALL=en_US.UTF-8
#     LANG=en_US.UTF-8
#     LANGUAGE=en_US.UTF-8
#     unicode_start
# fi

#unset -v HOME # Force bash to obtain its value for HOME from getpwent(3) on first use, so tilde-expansion is sane.

if shopt -q login_shell; then
    export TERM=xterm-256color
    if [[ -t 0 && $(tty) == /dev/tty7 && ! $DISPLAY ]]; then
        exec startx
    fi

    if [ -f ~/.bashrc ]; then
       source ~/.bashrc
    fi
fi
