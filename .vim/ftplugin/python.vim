" Python settings

" Autorun Black
"autocmd BufWritePre *.py silent! execute ':Black'
autocmd BufWritePre *.py execute ':silent Black'

" Indent for python
"au BufNewFile,BufRead *.py
    "\ set tabstop=4
    "\ set softtabstop=4
    "\ set shiftwidth=4
    "\ set textwidth=79
    "\ set expandtab
    "\ set autoindent
    "\ set fileformat=unix

" Set encoding for python
au BufNewFile, BufRead *.py
    \ set encoding=utf-8
    \ let python_highlight_all=1
    \ syntax on

autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
