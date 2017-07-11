scriptencoding utf-8
call plug#begin()
"Plug 'ajmwagar/vim-dues'
Plug 'vim-scripts/vimwiki'
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-css-color'
Plug 'benekastah/neomake'
Plug 'rperce/JavaImp.vim', { 'for': 'java', 'via': 'ssh' }
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'airblade/vim-gitgutter'
Plug 'tommcdo/vim-lion'
Plug 'torbiak/probe'
Plug 'tpope/vim-fugitive'
Plug 'rperce/L-syntax'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug '~/code/SmarterTabs'
Plug 'kchmck/vim-coffee-script'
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

" Current cursor's line highlighted
set cursorline

" colorscheme
colorscheme muon
" muon has really dark, unreadable comments. Let's brighten them up!
hi Comment ctermfg=DarkYellow cterm=bold
"colorscheme dues

" Literal tabs and trailing whitespace visible
set listchars=tab:┆-,trail:~,extends:>,precedes:<
set list
hi SpecialKey ctermfg=darkgray

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
" set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" But if my file already has tabs, that's okay
set copyindent

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

let g:JavaImpPaths = $JAVA_HOME . 'jre/lib/rt.jar'
let g:JavaImpDataDir = $HOME . '/.config/nvim/JavaImp'
let g:JavaImpSortPkgSep = 0

let g:neomake_cpp_clangcheck_maker = {
        \ 'exe': 'clang-check',
        \ 'args': ['%:p', '-std=c++11'],
        \ 'errorformat':
            \ '%-G%f:%s:,' .
            \ '%f:%l:%c: %trror: %m,' .
            \ '%f:%l:%c: %tarning: %m,' .
            \ '%f:%l:%c: %m,'.
            \ '%f:%l: %trror: %m,'.
            \ '%f:%l: %tarning: %m,'.
            \ '%f:%l: %m',
        \ }
let g:neomake_cpp_clang_maker = {
    \ 'args': ['-fsyntax-only', '-Wall', '-Wextra', '-std=c++11'],
    \ 'errorformat':
        \ '%-G%f:%s:,' .
        \ '%f:%l:%c: %trror: %m,' .
        \ '%f:%l:%c: %tarning: %m,' .
        \ '%f:%l:%c: %m,'.
        \ '%f:%l: %trror: %m,'.
        \ '%f:%l: %tarning: %m,'.
        \ '%f:%l: %m',
    \ }


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

nnoremap <leader>ev :vs $MYVIMRC<CR>
nnoremap <leader>sv :so %<CR>

" find makeprg
if filereadable('makefile')
    setlocal makeprg=make
elseif filereadable('Rakefile')
    setlocal makeprg=rake
end

command! Sw w !sudo tee %

nnoremap <leader>hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nnoremap <leader>f :FZF<CR>
nnoremap <silent> <F1> :UndotreeToggle<CR>

nnoremap <leader>kw :call InitMethods#DeleteTrailingWS()<cr>

set hidden
let g:racer_cmd = "/home/robert/.cargo/bin/racer"
let $RUST_SRC_PATH="/home/robert/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/"
let g:racer_experimental_completer = 1
