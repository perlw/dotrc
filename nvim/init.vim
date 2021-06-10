" Global
set nocompatible
filetype plugin on
set modelines=0
set nomodeline
set title
set nospell
set updatetime=100

if has('win32')
  " Can't suspend on Windows at the moment.
  nmap <C-z> <Nop>
endif

let mapleader=','
" Searching
nnoremap <leader><leader> :nohl<CR>

source ./config/plugins.vimrc

if exists('g:vscode')
  nnoremap <leader>s :<C-u>call VSCodeNotify('workbench.action.toggleSidebarVisibility')><CR>
  nnoremap <leader>t :<C-u>call VSCodeNotify('outline.focus')><CR>
else
  source ./config/generic.vimrc
  source ./config/statusline.vimrc
  source ./config/plugins/startify.vimrc
  source ./config/plugins/gitgutter.vimrc
  source ./config/plugins/go.vimrc
  source ./config/plugins/c.vimrc
  source ./config/plugins/compe.vimrc
  source ./config/plugins/saga.vimrc
  source ./config/plugins/todo.vimrc
  source ./config/plugins/treesitter.vimrc
  source ./config/plugins/lspconfig.vimrc
  source ./config/plugins/telescope.vimrc
endif

" plantuml call
nnoremap <leader>u :! plantuml -tutxt %<CR>
vnoremap <leader>u :'<,'>%! plantuml -tutxt -p<CR>

" graph-easy call
nnoremap <leader>g :! graph-easy --as=boxart %<CR>
vnoremap <leader>g :'<,'>%! graph-easy --as=boxart<CR>

" strikethrough
nnoremap <leader>- :s/./&̶/g<CR>:nohl<CR>

" easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
