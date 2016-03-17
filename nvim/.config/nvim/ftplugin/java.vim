exec "setlocal dict=" . g:JavaImpDataDir . "/JavaImp.txt"
setlocal complete-=k
setlocal complete+=k

inoremap <C-I> <Esc>:JavaImpSilent<Enter>a
nnoremap <leader>is :JIS<Enter>
