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
tnoremap <Esc> <C-\><C-n>

runtime ./config/plugins.vimrc

if exists('g:vscode')
  nnoremap <leader>s :<C-u>call VSCodeNotify('workbench.action.toggleSidebarVisibility')><CR>
  nnoremap <leader>t :<C-u>call VSCodeNotify('outline.focus')><CR>
else
  runtime ./config/generic.vimrc
  runtime ./config/statusline.vimrc
  runtime ./config/plugins/startify.vimrc
  runtime ./config/plugins/gitgutter.vimrc
  runtime ./config/plugins/go.vimrc
  runtime ./config/plugins/c.vimrc
  runtime ./config/plugins/compe.vimrc
  runtime ./config/plugins/saga.vimrc
  runtime ./config/plugins/todo.vimrc
  runtime ./config/plugins/treesitter.vimrc
  runtime ./config/plugins/lspconfig.vimrc
  runtime ./config/plugins/telescope.vimrc

  au BufEnter * let &titlestring=CwdBase() . " - " . expand("%:t")
  set title

  nnoremap <leader>t :TagbarToggle<CR>

  " strikethrough
  nnoremap <leader>- :s/./&̶/g<CR>:nohl<CR>

  " easy-align
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
endif

