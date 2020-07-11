#!/bin/bash
# shellcheck disable=SC2139

alias golf=~/.gem/ruby/2.7.0/bin/vimgolf
alias gpg2="gpg2 --homedir \"$XDG_DATA_HOME/gnupg\""
# alias gdb="gdb -nh -x \"$XDG_CONFIG_HOME/gdb/init\""
alias svn="svn --config-dir \"$XDG_CONFIG_HOME/subversion\""
alias mitmproxy="mitmproxy --set confdir=\"$XDG_CONFIG_HOME/mitmproxy\""
alias mitmweb="mitmweb --set confdir=\"$XDG_CONFIG_HOME/mitmproxy\""


# alias q='exit 0'
# alias d='clear'

# alias la='ls -Ah'
# alias ll='ls -lAh'
# alias l.='ls -ld .*'

alias mkdir='mkdir -pv'
alias debug="set -o nounset; set -o xtrace"
alias x='chmod +x'

alias du='du -kh'
alias df='df -kTh'

if hash nvim >/dev/null 2>&1; then
    alias vim='nvim'
    alias vom='nvim'
    alias v='nvim'
    alias sv='sudo nvim'
else
    alias v='vim'
    alias sv='sudo vim'
fi

alias f='ranger'


alias pkg='makepkg --printsrcinfo > .SRCINFO && makepkg -fsrc'
alias spkg='pkg --sign'

alias mk='make && make clean'
alias smk='sudo make clean install && make clean'
alias ssmk='sudo make clean install && make clean && rm -iv config.h'

# aliases inside tmux session
if [[ $TERM == *tmux* ]]; then
    alias :sp='tmux split-window'
    alias :vs='tmux split-window -h'
fi

alias rcp='rsync -v --progress'
alias rmv='rcp --remove-source-files'

alias calc='python -qi -c "from math import *"'
alias brok='sudo find . -type l -! -exec test -e {} \; -print'
alias timer='time read -p "Press enter to stop"'

# shellcheck disable=2142
alias xp='xprop | awk -F\"'" '/CLASS/ {printf \"NAME = %s\nCLASS = %s\n\", \$2, \$4}'"
alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'