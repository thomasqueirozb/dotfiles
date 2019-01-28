#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
HISTSIZE= HISTFILESIZE=
HISTCONTROL=ignoreboth

# Orginal
#PS1='[\u@\h \W]\$ '

# Fancy
#export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

# Fancier
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput sgr0)\]\\$ \[$(tput setaf 7)\]\[$(tput bold)\]"

# Fancy Structure
# [\u@\h \W] \\$

# [  #\[$(tput bold)\]\[$(tput setaf 1)\][
# \u #\[$(tput setaf 3)\]\u
# @  #\[$(tput setaf 2)\]@
# \h #\[$(tput setaf 4)\]\h 
# \W #\[$(tput setaf 5)\]\W
# ]  #\[$(tput setaf 1)\]]
# $  #\[$(tput setaf 7)\]\\$
#    #\[$(tput sgr0)\]"

# New
#export PS1="[\u@ \W] \\$ "

# New Fancy Structure
# [  #\[$(tput bold)\]\[$(tput setaf 1)\]\[$(tput blink)\][
# \u #\[$(tput setaf 3)\]\u
# @  #\[$(tput setaf 2)\]@
# \h #\[$(tput setaf 4)\]\h 
# \W #\[$(tput setaf 5)\]\W
# ]  #\[$(tput setaf 1)\]\[$(tput blink)\]]
# $  #\[$(tput setaf 7)\]\\$
#    #\[$(tput sgr0)\]"



# New Fancy
#export PS1="\[$(tput bold)\]\[$(tput setaf 1)\]\[$(tput blink)\][\[$(tput sgr0)\]\[$(tput bold)\]\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]\[$(tput blink)\]]\[$(tput setaf 7)\]\$\[$(tput sgr0)\]"


# Typos
alias cta='cat'
alias gerp='grep'
alias sl='ls'

# General
alias c='clear'
alias k='kill'
alias null='/dev/null'
alias mem='free -th --si'
alias ls='ls --color=auto --group-directories-first'
alias grep="grep --color='auto'"
alias ka='killall'

# Python
alias py='python'
alias pyi='python -i'

# 2
alias py2='python2'
alias py2.7='python2.7'
alias py27='python2.7'

# 3
alias py3='python3'
alias py3.6='python3.6'
alias py36='python3.6'
alias py3.7='python3.7'
alias py37='python3.7'


# Directories
alias home='cd ~'
alias dtop='cd ~/Desktop'
alias dload='cd ~/Downloads'
alias docs='cd ~/Documents'

alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ..; cd ..'
alias ....='cd ..; cd ..; cd ..'

# Github
alias u='git add -u'
alias com='git commit -m'
alias all='git add .'
alias st='git status'


# Pacman
alias spac='sudo pacman'
alias pac='pacman'

alias pacs='sudo pacman -S'
alias pacS='sudo pacman -S'

alias pacss='pacman -Ss'
alias pacSs='pacman -Ss'
alias search='pacman -Ss'


alias pacSyu='sudo pacman -Syu'
alias pacsyu='sudo pacman -Syu'
alias update='sudo pacman -Syu'

alias pacSyyu='sudo pacman -Syyu'
alias pacsyyu='sudo pacman -Syyu'
alias update-force='sudo pacman -Syyu'


alias pacsy='sudo pacman -Sy'
alias pacSy='sudo pacman -Sy'

alias remove='sudo pacman -R'
alias pacR='sudo pacman -R'
alias pacr='sudo pacman -R'

alias remove-all='sudo pacman -Rcdns'
alias pacRcdns='sudo pacman -Rcdns'
alias pacrcdns='sudo pacman -Rcdns'


# ping
alias pingg='ping -c 5 www.google.com'



neofetch
