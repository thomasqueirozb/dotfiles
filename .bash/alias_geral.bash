#!/bin/bash

# VIM
alias :q='exit'
alias :q!='exit'
alias :wq='exit'
alias :wq!='exit'

# Typos
alias cta='cat'
alias gerp='grep'


alias sl='ls'
alias l='ls'
alias la='ls'
alias ll='ls -lh'
alias lla='ls -lhA'
alias lal='ls -lhA'

# ..'s
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias .......='cd ../../../../../../'
alias ........='cd ../../../../../../../'
alias .........='cd ../../../../../../../../'
alias ..........='cd ../../../../../../../../../'

# General
alias c='clear'
alias e='exit 0'
alias k='kill'
alias mem='free -th --si'
alias ls='ls --color=auto --group-directories-first'
alias grep="grep --color='auto'"
alias ka='killall'
alias poff='systemctl poweroff'
alias mediainfo='mediainfo --Output=file://$HOME/.config/mediainfo'
alias feh='feh --conversion-timeout 1'

# ping
alias pingg='ping -c 5 www.google.com'
alias ping8='ping -c 5 8.8.8.8'
alias pingd='ping -c 5 www.duckduckgo.com'

#i3
alias i3conf='vim ~/.config/i3/config'

#weather
alias weather='curl wttr.in/-23.58,-46.71?1'
