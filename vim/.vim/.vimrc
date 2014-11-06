call pathogen#infect()

"""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""
" How much history do we care about?
set history=700

" This isn't vi
set nocompatible

" Enable filetype plugins
filetype plugin on
filetype indent on

" Auto-update when a file is externally changed
set autoread

" Extra key combos!
let mapleader = ","
let g:mapleader = ","

" Faster saving
nmap <leader>w :w<cr>
nmap <leader>a :wa<bar>qa<cr>

" Backspace acts sensibly
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

"""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual differences
"""""""""""""""""""""""""""""""""""""""""""""""""""
" SYNTAX HILIGHTING
syntax on

" AND LINE NUMBERS
set number

" Show current position
set ruler

" No annoying bells
set noerrorbells
set novisualbell
set t_vb=

" Shorter timeoutlen
set tm=500

" Color column at 80
highlight ColorColumn ctermbg=22
set cc=80

" I will probably never not use a dark, 256-color terminal
set bg=dark
set t_Co=256

" Gotta get that statusline, yo
set laststatus=2

" Visible tabs and trailing whitespace
set listchars=tab:\|=,trail:~,extends:>,precedes:<
set list

" Hilight matching braces
set showmatch

" See where the cursor is
set cursorline

"highlight Normal ctermbg=none
"""""""""""""""""""""""""""""""""""""""""""""""""""
" Behavior
"""""""""""""""""""""""""""""""""""""""""""""""""""
" Be sensible about cases when searching
set ignorecase
set smartcase
set incsearch

" Allow me to click if I'm in an X server
set mouse=a

" All my code is in git anyways
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""
" Indents and lines
"""""""""""""""""""""""""""""""""""""""""""""""""""
" Wrap lines, and autoindent them
set wrap
set autoindent

" All I want for Christmas is spaces
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Wrap text at 90 characters (80 plus some wiggle room)
set tw=90

"""""""""""""""""""""""""""""""""""""""""""""""""""
" Extra commands
"""""""""""""""""""""""""""""""""""""""""""""""""""
" Fumble-finger saving
command W w
command Wq wq
command WQ wq
command Q q
command Wa wa
command WA wa

" Who wants to move their pinkies?
map ; :
inoremap jk <Esc>

" Map 0 to go to the first non-blank character
map 0 ^

" Treat long lines as broken lines so you can move in them
map j gj
map k gk

" s and S work like i and a, but for a single character at a time (like r)
function! RepeatChar(char, count)
    return repeat(a:char, a:count)
endfunction
nnoremap s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>

" Move between windows a little easier
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Tab management
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>

" Open a new tab with current buffer's path
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/<cr>

" Set cwd to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Remember info about open buffers on close...
set viminfo^=%

" ...so we can return to last edit position when opening files
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! G`\"" |
    \ endif

" Kill trailing whitespace
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
map <leader>kw :call DeleteTrailingWS()<cr>

" Kill the Windows ^M if the encodings are screwy
map <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm


"""""""""""""""""""""""""""""""""""""""""""""""""""
" Miscellaneous
"""""""""""""""""""""""""""""""""""""""""""""""""""
" Need this for powerline, if you use that
let $PYTHONPATH="/usr/lib/python3.4/site-packages"

