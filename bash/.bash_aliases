# the space makes following commands expand, so I can sudo commands
alias sudo='sudo '
alias fucking='sudo'
alias q='exit'

alias pacins='sudo pacman -S'
alias pacrem='sudo pacman -R'
alias pacprg='sudo pacman -Rns'
alias pacunused='sudo pacman -Qqdt'

alias cless='ccze -A | less -R'
alias less='less -R'
alias ccze='ccze -A'

alias tmux='tmux -2'

alias texlink='ln -s ~/school/latex/* .'
alias gs='git status'
alias gh='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
alias gc='git commit -a -m'
alias fixsd='sudo mount -o remount,exec /dev/mmcblk1p1'

alias net='sudo netctl switch-to'
alias which='alias | which -i'
eval "$(thefuck --alias)"

alias ixio="curl -F 'f:1=<-' ix.io"
