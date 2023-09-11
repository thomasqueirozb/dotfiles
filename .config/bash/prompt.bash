#!/bin/bash

# shellcheck disable=2034

# Simple prompt for bash
# Written by Nathaniel Maia, 2018

# shell specific prompts

# using '' not "" means it will be evaluated when used as the prompt NOT when defined (below)
# this allows putting at the top of the file before the functions/variables have been defined

# bash uses \[..\]to wrap non printing chars
# this avoids issues with completion/history
RESET='\[\e[0m\]'     BOLD='\[\e[1m\]'
BLACK='\[\e[30m\]'
RED='\[\e[31m\]'      GREEN='\[\e[32m\]'
YELLOW='\[\e[1;33m\]' BLUE='\[\e[34m\]'
MAGENTA='\[\e[35m\]'  CYAN='\[\e[36m\]'
WHITE='\[\e[37m\]'    GRAY='\[\e[38m\]'
BRIGHT_RED='\[\e[39m\]' LIME='\[\e[40m\]'
# BRIGHT_YELLOW='\[\e[41m\]' LIME='\[\e[40m\]'

PROMPT_ARROW_COLOR="$GREEN"
PROMPT_CHROOT_DOCKER_COLOR="$RESET"
PROMPT_SSH_COLOR="$RESET"

# add some handy history commands, see `history --help`
PROMPT_COMMAND='export _exitcode=$?; history -n; history -w; history -c; history -r;'
PROMPT_COMMAND+='__git_ps1 "$(__title)${PROMPT_ARROW_COLOR}${PROMPT_LNBR1}$(__exitcode) '
PROMPT_COMMAND+='${PROMPT_USERFMT}${PROMPT_ARROW_COLOR}\w$(__ranger)${RESET}" '
PROMPT_COMMAND+='" ${PROMPT_MULTILINE}${PROMPT_ARROW_COLOR}${PROMPT_LNBR2}${PROMPT_ARROW}'

if [[ $(whoami) == 'root' ]]; then
    PROMPT_COMMAND+=' $(__ssh)$(__chroot_docker)${PROMPT_USERCOL}#${RESET} "'
else
    PROMPT_COMMAND+=' $(__ssh)$(__chroot_docker)${PROMPT_USERCOL}\$${RESET} "'
fi

PS2='==> '
PS3='choose: '
PS4='|${BASH_SOURCE} ${LINENO}${FUNCNAME[0]:+ ${FUNCNAME[0]}()}|  '

## ----------------------------------------------------------- ##

shopt -q promptvars || shopt promptvars >/dev/null 2>&1

# basic settings

: "${PROMPT_MULTILINE="\\n"}"

# PROMPT_MULTILINE=false

if [[ $(whoami) == 'root' ]]; then
    : "${PROMPT_USERCOL="$RED"}"
    : "${PROMPT_USERFMT="$PROMPT_USERCOL\\u$RESET@$RED\\h "}"
else
    : "${PROMPT_USERCOL="$CYAN"}"
    : "${PROMPT_USERFMT=""}"
fi

# avoid fancy symbol in the linux terminal
if [[ $PROMPT_MULTILINE ]]; then
    : "${PROMPT_LNBR1="┌"}"  # ┌ ┏ ╓ ╒
    : "${PROMPT_LNBR2="└"}"  # └ ┗ ╙ ╘
    : "${PROMPT_ARROW=">"}"  # ➜ ➤ ► ▻ ▸ ▹ ❯
fi

# git settings
: "${GIT_PS1_SHOWUPSTREAM="verbose git"}"
: "${GIT_PS1_SHOWDIRTYSTATE="true"}"
: "${GIT_PS1_SHOWCOLORHINTS="true"}"
: "${GIT_PS1_SHOWSTASHSTATE="true"}"
: "${GIT_PS1_SHOWUNTRACKEDFILES="true"}"

# print if running in ssh
__ssh()
{
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        printf "${PROMPT_SSH_COLOR}(ssh) "
    fi
}

# print if in docker container or in chroot
__chroot_docker()
{
    if [ -f /.dockerenv ]; then
        printf "${PROMPT_CHROOT_DOCKER_COLOR}(docker) "
    else
        [ "$(/usr/bin/env ls -di /)" = "2 /" ] || printf "${PROMPT_CHROOT_DOCKER_COLOR}(chroot) "
    fi
}

# print last command's exit code in red
__exitcode()
{
    # shellcheck disable=2154
    [ $_exitcode = "0" ] || printf " \e[31m$_exitcode"
}

# print blue '(r)' when in a nested ranger shell
__ranger()
{
    if [[ $RANGER_LEVEL ]]; then
        (( RANGER_LEVEL == 1 )) && printf " $BLUE(ranger)" || printf " $BLUE(ranger:$RANGER_LEVEL)"
    fi
}

# set the terminal title
__title()
{
    title="\W"
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        title="$USER@$(cat /etc/hostname) - ${title}"
    fi

    # [[ $TERM =~ (xterm|rxvt|st) ]] && printf "%s" '\[\033]0;$USER: $(basename $SHELL) - \w\007\]'
    [[ $TERM =~ (xterm|rxvt|st) ]] && printf "%s" "\[\033]0;$title\007\]"
    return 0
}

source "$HOME/.config/bash/git-prompt.sh"
