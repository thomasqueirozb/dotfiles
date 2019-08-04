# if [ -o interactive ] && [ -f ~/.bashrc ]; then
# if [ -o interactive ]; then
#     LC_ALL=en_US.UTF-8
#     LANG=en_US.UTF-8
#     LANGUAGE=en_US.UTF-8
#     unicode_start
# fi

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
   export $TERM=xterm-256color
fi
#unset -v HOME # Force bash to obtain its value for HOME from getpwent(3) on first use, so tilde-expansion is sane.
if shopt -q login_shell; then
    [[ -t 0 && $(tty) == /dev/tty1 && ! $DISPLAY ]] && exec startx
fi
