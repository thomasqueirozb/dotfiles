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
