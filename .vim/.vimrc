call pathogen#infect()

set nocompatible
set tw=80
filetype off
set laststatus=2

syntax on
set number
set cc=80
set mouse=a

set showmatch
set nowrap
set autoindent
set cursorline
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set bg=dark
highlight ColorColumn ctermbg=22
set t_Co=256
colorscheme wombat256mod
highlight Normal ctermbg=none

command W w
command Wq wq
command WQ wq
command Q q

filetype plugin indent on

let $PYTHONPATH="/usr/lib/python3.4/site-packages"

map ; :
noremap ;; ;
