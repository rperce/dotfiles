call pathogen#infect()

set backspace=indent,eol,start
set nocompatible
set tw=80
filetype plugin on
set laststatus=2

syntax on
set number
set cc=80
set mouse=a

set listchars=tab:\|=,trail:~,extends:>,precedes:<
set list

set backupdir=~/.vim/backup//,.
set directory=~/.vim/swap//,.
set undodir=~/.vim/undo//,.

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
"colorscheme wombat256mod
highlight Normal ctermbg=none

command W w
command Wq wq
command WQ wq
command Q q

filetype plugin indent on

let $PYTHONPATH="/usr/lib/python3.4/site-packages"

map ; :
inoremap jk <Esc>

function! RepeatChar(char, count)
    return repeat(a:char, a:count)
endfunction
nnoremap s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>

