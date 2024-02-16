#!/usr/bin/env bash
# catch non-bash and non-interactive shells
[[ $- == *i* && $BASH_VERSION ]] && SHELL=bash || return 0

(uname -s | grep -q Darwin) && {
    # Remove annoying deprecation message
    export BASH_SILENCE_DEPRECATION_WARNING=1
    unset POSIXLY_CORRECT
}

. ~/.config/bash/path_env


# set some defaults
# export HISTSIZE=10000
export HISTSIZE=
export HISTFILESIZE=
export HISTCONTROL=ignoreboth:ignoredups:erasedups
export HISTIGNORE="q:f:v"

# colors in less (manpager)
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'

export LESSHISTFILE="-"

set -o vi

bind -m vi-command "Control-l:clear-screen"
bind -m vi-insert "Control-l:clear-screen"

set -o notify

shopt -s direxpand 2>/dev/null
shopt -s checkhash
shopt -s sourcepath
shopt -s expand_aliases
shopt -s extglob dotglob
shopt -s no_empty_cmd_completion
shopt -s autocd 2>/dev/null
shopt -s cdspell
shopt -s cmdhist histappend histreedit histverify
[[ $DISPLAY ]] && shopt -s checkwinsize

# prompt if file sourcing below fails
PS1='[\u@\h \W]\$ '

# uncomment these lines to disable the multi-line prompt
# add user@host, and remove the unicode line-wrap characters

# export PROMPT_LNBR1=''
# export PROMPT_MULTILINE=''
# export PROMPT_USERFMT='\u\[\e[0m\]@\[\e[31m\]\h '

# source shell configs
for f in "$XDG_CONFIG_HOME/bash/"*?.bash; do
    # shellcheck source=/dev/null
    . "$f"
done

if command -v brew >/dev/null 2>&1; then
    prefix="$(brew --prefix)"
    # shellcheck source=/dev/null
    if [ -d "$prefix/etc/bash_completion.d/" ]; then
        # shellcheck source=/dev/null
        for f in "$prefix/etc/bash_completion.d/"*; do
            # shellcheck source=/dev/null
            . "$f"
        done
    fi
    unset prefix
fi
unset f

#al-info
# neofetch
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
fi

ls
