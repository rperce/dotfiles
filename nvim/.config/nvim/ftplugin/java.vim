exec "setlocal dict=" . g:JavaImpDataDir . "/JavaImp.txt"
setlocal complete-=k
setlocal complete+=k

inoremap ii <Esc>:JavaImpSilent<Enter>a
nnoremap <leader>is :JIS<Enter>
