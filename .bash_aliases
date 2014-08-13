alias fucking='sudo'
alias q='exit'

alias pacupg='sudo pacman -Syu'
alias pacins='sudo pacman -S'
alias pacinu='sudo pacman -U'
alias pacrem='sudo pacman -R'
alias pacprg='sudo pacman -Rns'
alias pacrep='sudo pacman -Si'
alias paccln='sudo pacman -Scc'

alias cless='ccze -A | less -R'
alias less='less -R'
alias ccze='ccze -A'

alias renet='sudo netctl restart `netctl list | grep -Po "(?<=\* )(.+)"`'

alias tmux='tmux -2'
