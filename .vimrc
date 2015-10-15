let g:glsl_file_extensions = '*.glsl,*.vsh,*.fsh,*.frag,*.vert'

execute pathogen#infect()

" Generic settings
set enc=utf-8
syntax on
filetype plugin indent on
set relativenumber
set nowrap
set cursorline
autocmd InsertEnter * :set norelativenumber | :set number
autocmd InsertLeave * :set nonumber | :set relativenumber

" Extra paths
let $GOPATH = "~/Projects/go"

" NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeShowLineNumbers = 1

" CtrlP
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }

" Tabs
set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab

" Splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
set splitbelow
set splitright

" Tabular
let mapleader=','
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

" jsx
let g:jsx_ext_required = 0

" Eyecandy
if has('gui_running')
    if has("win32")
        set guifont=PragmataPro:h10
    else
        set guifont=PragmataPro:h12
    endif

	" Turning off scrollbars
	set guioptions-=r
	set guioptions-=R
	set guioptions-=l
	set guioptions-=L
    set guioptions-=T
    set guioptions-=m
endif
" airline
let g:airline_powerline_fonts = 1

"color jellybeans
set background=dark
color base16-ocean
set fillchars=vert:\ 
hi NonText guifg=bg

"hi ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
"au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"au InsertLeave * match ExtraWhitespace /\s\+$/
