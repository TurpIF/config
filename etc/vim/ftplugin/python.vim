" PEP 8 recommendations
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set softtabstop=4
set autoindent

" Code folding
set foldmethod=indent
set foldlevel=99

" Indent after writting a colon : follow by a return
" imap :<cr> :<cr><tab>

" Remove extra whitespace at the end of lines
autocmd BufWritePre <buffer> normal m`:%s/\s\+$//e``
