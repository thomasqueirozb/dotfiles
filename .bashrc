#!/usr/bin/env bash
# catch non-bash and non-interactive shells
[[ $- == *i* ]] || return 0

IN_BASH=1
IN_ZSH=0

current_shell="$(ps -p $$ -o comm='')"
[[ "$current_shell" == *bash ]] && {
    IN_BASH=1
    IN_ZSH=0
}

[[ "$current_shell" == *zsh ]] && {
    IN_ZSH=1
    IN_BASH=0
}

[[ $IN_BASH = 0 && $IN_ZSH = 0 ]] && return 0

(uname -s | grep -q Darwin) && {
    # Remove annoying deprecation message
    export BASH_SILENCE_DEPRECATION_WARNING=1
    unset POSIXLY_CORRECT
}

. ~/.config/bash/path_env


# set some defaults
# export HISTSIZE=10000
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

if [ $IN_BASH = 1 ]; then
    export HISTSIZE=
    export HISTFILESIZE=

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
elif [ $IN_ZSH = 1 ]; then
    bindkey -v
    bindkey '^L' clear-screen

    setopt notify

    setopt direxpand 2>/dev/null
    setopt hashcmds
    setopt aliases
    setopt extended_glob dot_glob
    unsetopt correct_all
    setopt autocd 2>/dev/null
    setopt correct
    setopt hist_ignore_space hist_find_no_dups hist_ignore_all_dups hist_ignore_dups

    unsetopt LIST_BEEP

    # zsh specific
    bindkey "^[[1;5C" forward-word
    bindkey "^[[1;5D" backward-word

    # bash polyfills. They cannot be empty otherwise bash thinks this is a syntax error
    complete() {
        true
    }

    shopt() {
        true
    }
fi

# prompt if file sourcing below fails
PS1='[\u@\h \W]\$ '

# uncomment these lines to disable the multi-line prompt
# add user@host, and remove the unicode line-wrap characters

# export PROMPT_LNBR1=''
# export PROMPT_MULTILINE=''
# export PROMPT_USERFMT='\u\[\e[0m\]@\[\e[31m\]\h '

# source shell configs
for f in "$XDG_CONFIG_HOME/bash/"*?.sh; do
    # shellcheck source=/dev/null
    . "$f"
done

if [ $IN_BASH = 1 ]; then
    for f in "$XDG_CONFIG_HOME/bash/"*?.bash; do
        # shellcheck source=/dev/null
        . "$f"
    done
elif [ $IN_ZSH = 1 ]; then
    for f in "$XDG_CONFIG_HOME/bash/"*?.zsh; do
        # shellcheck source=/dev/null
        . "$f"
    done
fi

if command -v brew >/dev/null 2>&1; then
    prefix="$(brew --prefix)"

    if [ $IN_BASH = 1 ]; then
        # shellcheck source=/dev/null
        if [ -d "$prefix/etc/bash_completion.d/" ]; then
            # shellcheck source=/dev/null
            for f in "$prefix/etc/bash_completion.d/"*; do
                # shellcheck source=/dev/null
                . "$f"
            done
        fi
        unset prefix
        unset f
    elif [ $IN_ZSH = 1 ]; then
        fpath+="$prefix/share/zsh/site-functions"
    fi
fi

if [ $IN_ZSH = 1 ]; then
    # Initialize Zsh completion
    autoload -Uz compinit
    compinit

    zstyle ':completion:*' menu select
    zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

    setopt menu_complete
fi

if command -v zoxide >/dev/null 2>&1; then
    if [ $IN_BASH = 1 ]; then
        shell_name="bash"
    elif [ $IN_ZSH = 1 ]; then
        shell_name="zsh"
    fi

    eval "$(zoxide init $shell_name)"
fi

ls
