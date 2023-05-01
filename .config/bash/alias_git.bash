#!/bin/bash

# Git

alias gti='git'

alias u='git add -u'

alias gp='git pull'
alias gap='git add -p'
alias gf='git fetch'
alias gfu='git fetch upstream'
alias gc='git clone'
alias gs='git status'
alias s='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gb='git branch'
alias gm='git merge'
alias gch='git checkout'
alias gcm='git commit -m'
alias glg='git log --stat'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'

alias gcan='git commit --amend --no-edit'
alias gpo='git push origin'
alias gpob='git rev-parse --abbrev-ref HEAD | xargs -r git push origin'
