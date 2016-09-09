set cole=2
let g:tex_conceal='adgm'
hi Conceal ctermbg=none

setlocal errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m
if filereadable('makefile')
    setlocal makeprg=make\ %<.pdf
else
    exec "setlocal makeprg=make\\ -f\\ ~/school/lates/makefile\\ " . substitute(bufname("%"),"tex$","pdf", "")
end

map <leader>c :BuildTexPdf %<.pdf<Return>
