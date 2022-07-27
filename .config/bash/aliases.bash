#!/bin/bash


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



# aliases inside tmux session
if [[ $TERM == *tmux* ]]; then
    alias :sp='tmux split-window'
    alias :vs='tmux split-window -h'
fi
