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

alias renet='sudo systemctl restart netctl-auto@wlo1'
alias net='sudo netctl switch-to'
alias which='alias | which -i'

alias ixio="curl -F 'f:1=<-' ix.io"
alias vim="nvim"

alias steam=$'LD_PRELOAD=\'/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1 /usr/$LIB/libgpg-error.so\' /usr/bin/steam'

export KPARAMS="root=/dev/nvme0n1p3 rw initrd=/initramfs-linux.img resume=/dev/nvme0n1p2"
alias efibootset=$'efibootmgr -d /dev/nvme0n1 -p 1 -c -L "Arch Linux" -l /vmlinuz-linux -u "'"$KPARAMS"'"'

