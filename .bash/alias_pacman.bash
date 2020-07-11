#!/bin/bash

# Pacman
alias spac='sudo pacman'
alias pac='pacman'

alias pacs='sudo pacman -S'
alias pacS='sudo pacman -S'

alias pacss='pacman -Ss'
alias pacSs='pacman -Ss'


alias pacSyu='sudo pacman -Syu'
alias pacsyu='sudo pacman -Syu'

alias pacSu='sudo pacman -Su'
alias pacsu='sudo pacman -Su'


alias pacSyyu='sudo pacman -Syyu'
alias pacsyyu='sudo pacman -Syyu'


alias pacsy='sudo pacman -Sy'
alias pacSy='sudo pacman -Sy'

alias pacsyy='sudo pacman -Syy'
alias pacSyy='sudo pacman -Syy'

alias pacR='sudo pacman -R'
alias pacr='sudo pacman -R'

alias remove-all='sudo pacman -Rcdns'
alias pacRcdns='sudo pacman -Rcdns'
alias pacrcdns='sudo pacman -Rcdns'

alias pacsi='pacman -Si'
alias pacSi='pacman -Si'
alias pacinfo='pacman -Si'




# alias pup='sudo pacman -Syyu' # update
# alias pin='sudo pacman -S'    # install
# alias pun='sudo pacman -Rs'   # remove
alias pcc='sudo pacman -Scc'  # clear cache
# alias pls='pacman -Ql'        # list files
# alias prm='sudo pacman -Rnsc' # really remove, configs and all
alias remove-orphans='sudo pacman -Rcdns $(pacman -Qtdq)'
