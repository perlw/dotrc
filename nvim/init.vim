" Global
function! CwdBase()
  return fnamemodify(getcwd(), ':t')
endfunction

set nocompatible
filetype plugin on
set modelines=0
set nomodeline
set nospell
set nodigraph
set updatetime=100
set backupcopy=yes
if has('win32')
  " Can't suspend on Windows at the moment.
  nmap <C-z> <Nop>
endif

let mapleader=','
" Searching
nnoremap <leader><leader> :nohl<CR>
" Term
tnoremap <leader>- <C-\><C-n>
nnoremap <leader>l :spl\|lcd %:h\|term<CR>

runtime ./config/plugins.vimrc

runtime ./config/generic.vimrc
runtime ./config/statusline.vimrc
runtime ./config/tabline.vimrc
runtime! ./config/plugins/**/*

au BufEnter * let &titlestring=CwdBase() . " - " . expand("%:t")
set title

" strikethrough
nnoremap <leader>- :s/./&̶/g<CR>:nohl<CR>

" easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" folds
nnoremap <space> za
