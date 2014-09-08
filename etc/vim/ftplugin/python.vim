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

" vim-flake8
" map <silent> <buffer> <F7> :call Flake8()<CR>
map <silent> <buffer> <leader>p :call Flake8()<CR>

" autocmd BufWritePost <buffer> call Flake8()
let g:flake8_ignore="E501,W293,E901,E128,E126,E127"
let g:flake8_max_line_length=80
let g:flake8_max_complexity=10
