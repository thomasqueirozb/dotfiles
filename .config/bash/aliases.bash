#!/bin/bash
# vim:foldmethod=marker

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# vim {{{
if hash nvim >/dev/null 2>&1; then
    export EDITOR=nvim
    alias bim='nvim'
    alias vim='nvim'
    alias vom='nvim'
    alias v='nvim'
    alias sv='sudo nvim'
else
    export EDITOR=vim
    alias v='vim'
    alias sv='sudo vim'
fi

alias :q='exit'
alias :q!='exit'
alias :wq='exit'
alias :wq!='exit'
# }}}

# tmux {{{
if [[ $TERM == *tmux* ]]; then
    alias :sp='tmux split-window'
    alias :vs='tmux split-window -h'
fi
# }}}

# vim {{{
alias :q='exit'
alias :q!='exit'
alias :wq='exit'
alias :wq!='exit'
# }}}

# Typos {{{
alias cdc='cd'
alias cta='cat'
alias car='cat'
alias gerp='grep'
alias sl='ls'
alias gti='git'
# }}}

# ls {{{
alias ls='ls --color=auto --group-directories-first'

alias l='ls'
alias la='ls'
alias ll='ls -lh'
alias lla='ls -lhA'
alias lal='ls -lhA'
alias l.='ls -ld .*'
# }}}

# ..'s {{{
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias .......='cd ../../../../../../'
alias ........='cd ../../../../../../../'
alias .........='cd ../../../../../../../../'
alias ..........='cd ../../../../../../../../../'
# }}}

# Prevent overwriting files (cp/mv) {{{
alias cp='cp -i'
alias mv='mv -i'
# alias rm='rm -i'
# }}}

# ping {{{
alias pingg='ping -c 5 www.google.com'
alias ping8='ping -c 5 8.8.8.8'
alias pingd='ping -c 5 www.duckduckgo.com'
# }}}

# Config files {{{
alias i3conf='$EDITOR ~/.config/i3/config'
alias vimconf='$EDITOR ~/.config/nvim/init.vim'
# }}}

# Redefinitions {{{
alias grep="grep --color='auto'"
alias du='du -h'
alias df='df -Th'
alias mkdir='mkdir -pv'
alias feh='feh --conversion-timeout 1'
# }}}

# Short conveniences {{{
alias c='clear'
alias o='open'
alias e='exit 0'
alias r='ranger'
alias k='kill'
alias x='chmod +x'
alias xk='xkill'
alias ka='killall'
alias poff='systemctl poweroff'
alias mem='free -th --si'
# }}}

# More complex stuff {{{
alias weather='curl wttr.in/-23.58,-46.71?1'


alias mediainfo='mediainfo --Output=file://$HOME/.config/mediainfo'

alias debug="set -o nounset; set -o xtrace"

alias pkg='makepkg --printsrcinfo > .SRCINFO && makepkg -fsrc'
alias spkg='pkg --sign'

alias rcp='rsync -v --progress'
# alias rmv='rcp --remove-source-files'

alias calc='python -qi -c "from math import *"'
alias brok='sudo find . -type l -! -exec test -e {} \; -print'
alias timer='time read -p "Press enter to stop"'

# shellcheck disable=2142
alias xp='xprop | awk -F\"'" '/CLASS/ {printf \"NAME = %s\nCLASS = %s\n\", \$2, \$4}'"
alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'

# alias mk='make && make clean'
# alias smk='sudo make clean install && make clean'
# }}}
