# the space makes following commands expand, so I can sudo commands
alias sudo='sudo '
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

alias steamfix='find ~/.steam/root/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" \) -print -delete'
alias texlink='ln -s ~/school/latex/* .'
alias gs='git status'
alias gh='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
alias gc='git commit -a -m'
alias fixsd='sudo mount -o remount,exec /dev/mmcblk1p1'
