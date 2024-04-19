#!/usr/bin/env bash

alias j='just'
alias jr='just run'
alias jt='just test'
alias jta='just test-all'
alias jb='just build'

complete -F _just -o bashdefault -o default j
