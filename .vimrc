execute pathogen#infect()

" Generic settings
set enc=utf-8
syntax on
filetype plugin indent on
set number
set nowrap
set cursorline

" Extra paths
let $GOPATH = "~/Projects/go"

" Autocommands
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

if has("win32")
    let g:syntastic_cpp_compiler = 'g++'
    let g:syntastic_cpp_compiler_options = ' -std=c++11 -pedantic-errors -Wall'
else
    let g:syntastic_cpp_compiler = 'clang++'
    let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++ -pedantic-errors -Weverything'
endif

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

" GLSL
let g:glsl_file_extensions = '*.glsl,*.vsh,*.fsh,*.frag,*.vert'

" Eyecandy
if has('gui_running')
	set guifont=PragmataPro:h10

	" Turning off scrollbars
	set guioptions-=r
	set guioptions-=R
	set guioptions-=l
	set guioptions-=L
    set guioptions-=T
    set guioptions-=m

	" airline
	let g:airline_powerline_fonts = 1
endif
color jellybeans
set fillchars=vert:\ 
hi NonText guifg=bg
