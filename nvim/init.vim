" Global
function! CwdBase()
  return fnamemodify(getcwd(), ':t')
endfunction

set nocompatible
filetype plugin on
set modelines=0
set nomodeline
set nospell
set updatetime=100
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

if exists('g:vscode')
  nnoremap <leader>s :<C-u>call VSCodeNotify('workbench.action.toggleSidebarVisibility')><CR>
  nnoremap <leader>t :<C-u>call VSCodeNotify('outline.focus')><CR>
else
  runtime ./config/generic.vimrc
  runtime ./config/statusline.vimrc
  runtime! ./config/plugins/**/*

  au BufEnter * let &titlestring=CwdBase() . " - " . expand("%:t")
  set title

  " strikethrough
  nnoremap <leader>- :s/./&̶/g<CR>:nohl<CR>

  " easy-align
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
endif

