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

" Jedi - May the force be with you
let g:jedi#auto_initialization = 1
let g:jedi#completions_command = "<C-n>"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#popup_on_dot = 0
