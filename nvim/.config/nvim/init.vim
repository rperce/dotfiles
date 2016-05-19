scriptencoding utf-8
call plug#begin()
Plug 'vim-scripts/vimwiki'
Plug 'itchyny/lightline.vim'
Plug 'cespare/vim-align'
Plug 'ap/vim-css-color'
Plug 'benekastah/neomake'
Plug 'rperce/JavaImp.vim', { 'for': 'java', 'via': 'ssh' }
Plug 'rperce/goyo.vim', { 'via': 'ssh' }
Plug 'junegunn/limelight.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'airblade/vim-gitgutter'
Plug 'tommcdo/vim-lion'
Plug 'torbiak/probe'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""
" How much history do we care about (in terms of lines of commands)?
set history=700

" Auto-update when a file is externally changed
set autoread

" Extra key combos!
" let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

" Faster saving
noremap <leader>w :w<cr>
nnoremap <leader>a :wa<bar>qa<cr>

" h and l on the edges of lines wrap around
set whichwrap+=<,>,h,l

" Shorter timeoutlen
set timeoutlen=250

" Short updatetime -- more cpu, barely, but up-to-date gitgutter. In ms.
set updatetime=500


"""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual differences
"""""""""""""""""""""""""""""""""""""""""""""""""""
" Line numbers, PLEASE
set relativenumber
set number

" I'll probably never be in a non-dark terminal
set background=dark

" Colored column at column 80
highlight ColorColumn ctermbg=22
set colorcolumn=90

set nohlsearch

" Literal tabs and trailing whitespace visible
set listchars=tab:\|=,trail:~,extends:>,precedes:<
set list

" Current cursor's line highlighted
set cursorline

" colorscheme
colorscheme muon

" Lightline already tells me this
set noshowmode

" Have at least three lines at the edge of the screen
" for some context, as long as we scrolled there
set scrolloff=3

" Enable pretty pipe cursor on insert mode
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
"""""""""""""""""""""""""""""""""""""""""""""""""""
" Behavior
"""""""""""""""""""""""""""""""""""""""""""""""""""
" Be sensible about cases when searching
set ignorecase
set smartcase

" and move as a type a search term
set incsearch

" Allow me to click if I'm in an X server
set mouse=a

" All my code is in git anyways
set nobackup
set nowritebackup
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""
" Indents and lines
"""""""""""""""""""""""""""""""""""""""""""""""""""
" don't softwrap lines, but autoindent them
set nowrap
set autoindent

" All I want for Christmas is spaces
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Hard wrap text at 90 characters (80 plus some wiggle room)
set textwidth=90

"""""""""""""""""""""""""""""""""""""""""""""""""""
" Extra commands
"""""""""""""""""""""""""""""""""""""""""""""""""""
" Fumble-finger saving
command! W w
command! Wq wq
command! WQ wq
command! Q q
command! Wa wa
command! WA wa

" Who wants to move their pinkies?
" map ; : " uncomment if you don't use f
inoremap jk <Esc>

" Treat long lines as broken lines so you can move in them
nnoremap j gj
nnoremap k gk

" s and S work like i and a, but for a single character at a time (like r)
nnoremap s :<C-U>exec "normal i" . InitMethods#RepeatInput()<CR>
nnoremap S :<C-U>exec "normal a" . InitMethods#RepeatInput()<CR>

" Move between windows a little easier
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
noremap <Tab> <C-W>w
noremap <S-Tab> <C-W>W

" fast split opening
nnoremap <expr><silent> \| !v:count ? "<C-W>v<C-W><Right>" : '\|'
nnoremap <expr><silent> _  !v:count ? "<C-W>s<C-W><Down>"  : '_'

" Tab management
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tx :tabclose<cr>

" Open a new tab with current buffer's path
nnoremap <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/<cr>

nnoremap <leader>kw :call InitMethods#DeleteTrailingWS()<cr>

" Kill the Windows ^M if the encodings are screwy
nnoremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle printing whitespace
nnoremap <leader>l :set list!<CR>

" Set vimwiki to be its own dir
let g:vimwiki_list = [{'path': '~/vimwiki'}]

"""""""""""""""""""""""""""""""""""""""""""""""""""
" Miscellaneous
"""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
    \ 'separator': {'left': '▓▓▒', 'right': '▒▓▓'},
    \ 'subseparator': {'left': '⡇⡷', 'right': '⢾⢸'}
    \ }

let g:JavaImpPaths =
    \ $JAVA_HOME . 'jre/lib/rt.jar'
let g:JavaImpDataDir = $HOME . '/.config/nvim/JavaImp'
let g:JavaImpSortPkgSep = 0

" Neomake aaaaaaall the things
if filereadable('makefile') || filereadable('Rakefile')
    augroup Neomake
        autocmd!
        autocmd! BufWritePost * silent Neomake!
    augroup END
else
    augroup Neomake
        autocmd!
        autocmd! BufWritePost * Neomake
    augroup END
end

" (but quietly)
let g:neomake_verbose = 0

" find makeprg
if filereadable('makefile')
    setlocal makeprg=make
elseif filereadable('Rakefile')
    setlocal makeprg=rake
end

augroup GoyoLimelight
    autocmd!
    autocmd! User GoyoEnter call InitMethods#GoyoEnter()
    autocmd! User GoyoLeave call InitMethods#GoyoLeave()
augroup END

command! Sw w !sudo tee %

nnoremap <leader>hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
