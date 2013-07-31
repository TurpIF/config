" Local configuration for C++

" Set omni completion function
setlocal omnifunc=omni#cpp#complete#Main

" Change the fold method
setlocal foldmethod=syntax

" Set the wild menu format
setlocal completeopt=menuone,menu,longest

" Add some things to the path (for the STL for instance)
setlocal path+=/usr/include/c++/4.7/*

" Use some default option (can be change locally with a .clang_complete file)
let g:clang_user_options = '-std=c++11'

" Use libclang instead of clang/clang++
let g:clang_use_library = 1

" Build Ctags with Ctrl-F12
nmap <buffer> <C-F12> :!ctags -R --sort=yes --c++-kinds=+px-d --fields=+iaS --extra=+q .<cr>

" Fswitch
nmap <silent> <leader>of :FSHere<cr>
" nmap <silent> <leader>ol :FSRight<cr>
" nmap <silent> <leader>oL :FSSplitRight<cr>
" nmap <silent> <leader>oh :FSLeft<cr>
" nmap <silent> <leader>oH :FSSplitLeft<cr>
" nmap <silent> <leader>ok :FSAbove<cr>
" nmap <silent> <leader>oK :FSSplitAbove<cr>
" nmap <silent> <leader>oj :FSBelow<cr>
" nmap <silent> <leader>oJ :FSSplitBelow<cr>

" OmniCppComplete plugin
let OmniCpp_DefaultNamespaces   = []
let OmniCpp_NamespaceSearch     = 0
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_ShowAccess          = 1
let OmniCpp_MayCompleteArrow    = 1
let OmniCpp_MayCompleteScope    = 1
let OmniCpp_MayCompleteDot      = 1
