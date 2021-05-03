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
nnoremap <leader><leader> :nohl<cr>

" Plug
call plug#begin('~/.config/nvim/bundle')

if !exists('g:vscode')
  " Vim settings/improvements
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-speeddating'
  Plug 'tpope/vim-surround'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'KabbAmine/zeavim.vim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'neoclide/coc.nvim', { 'do': { -> coc#util#install() }}
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'tpope/vim-vinegar'
  Plug 'sakshamgupta05/vim-todo-highlight'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'preservim/nerdtree'
  Plug 'preservim/tagbar'
  " Style/sexy
  Plug 'lifepillar/vim-solarized8'
  Plug 'sainnhe/gruvbox-material'
  Plug 'aonemd/kuroi.vim'
  Plug 'ayu-theme/ayu-vim'
  Plug 'Yggdroot/indentLine'
  " File and syntax
  Plug 'mustache/vim-mustache-handlebars'
  Plug 'gabrielelana/vim-markdown'
  Plug 'petrbroz/vim-glsl'
  Plug 'rhysd/vim-clang-format'
  Plug 'rust-lang/rust.vim'
  Plug 'cespare/vim-toml'
  Plug 'tpope/vim-fugitive'
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
  Plug 'fatih/vim-go'
  Plug 'jansedivy/jai.vim'
  Plug 'leafgarland/typescript-vim'
  Plug 'lifepillar/pgsql.vim'
  Plug 'aklt/plantuml-syntax'
  Plug 'PProvost/vim-ps1'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'ekalinin/Dockerfile.vim'
  " Others
  Plug 'wakatime/vim-wakatime'
endif

Plug 'tpope/vim-sensible'
Plug 'junegunn/vim-easy-align'

call plug#end()

if exists('g:vscode')
  nnoremap <leader>s :<C-u>call VSCodeNotify('workbench.action.toggleSidebarVisibility')><cr>
  nnoremap <leader>t :<C-u>call VSCodeNotify('outline.focus')><cr>
else
  " Generic settings
  set enc=utf-8
  set relativenumber
  set number
  set nowrap
  au InsertEnter * :set norelativenumber
  au InsertLeave * set number | :set relativenumber
  au FileType make set noexpandtab
  au FileType rust set ts=4 sw=4 sts=4
  au FileType c set ts=2 sw=2 sts=2
  au BufRead,BufNewFile *.rs set ts=4 sw=4 sts=4
  au BufRead,BufNewFile *.c set ts=2 sw=2 sts=2
  au BufRead,BufNewFile *.h set ts=2 sw=2 sts=2
  set nobackup
  set noswapfile
  set mouse=n
  set path+=**
  set wildmenu
  filetype indent plugin on
  syn on
  set cc=120
  set lazyredraw
  set maxmempattern=20000

  " local vim config support
  silent! so .vimlocal

  " netrw
  let g:netrw_bufsettings = 'noma nomod nu nowrap ro nobl'

  " Deoplete
  let g:deoplete#enable_at_startup=1

  " LanguageClient
  let g:LanguageClient_rootMarkers = {
          \ 'go': ['.git', 'go.mod'],
          \ }

  " Eyecandy
  set cursorline
  autocmd WinEnter,BufEnter,BufWinEnter * set cursorline
  autocmd WinLeave,BufLeave,BufWinLeave * set nocursorline
  set termguicolors
  " color gruvbox-material
  " color kuroi
  let ayucolor="mirage"
  color ayu
  set fillchars=vert:\|
  hi! VertSplit guifg=gray

  function! ToggleBackground()
    if &background ==# 'dark'
      set background=light
      color solarized8_high
    else
      set background=dark
      color gruvbox-material
    endif
  endfunction
  nnoremap <f2> :call ToggleBackground()<cr>

  " Statusline
  function! InsertStatuslineColor(mode)
    if a:mode == 'i'
      hi statusline ctermbg=darkgreen guibg=darkgreen cterm=NONE gui=NONE
    elseif a:mode == 'r'
      hi statusline ctermbg=darkmagenta guibg=darkmagenta cterm=NONE gui=NONE
    else
      hi statusline ctermbg=red guibg=red cterm=NONE gui=NONE
    endif
  endfunction
  au InsertEnter * call InsertStatuslineColor(v:insertmode)
  au InsertChange * call InsertStatuslineColor(v:insertmode)
  au InsertLeave * hi statusline ctermbg=grey guibg=grey ctermfg=yellow guifg=yellow cterm=NONE gui=NONE
  hi statusline ctermbg=grey guibg=grey ctermfg=yellow guifg=yellow cterm=NONE gui=NONE

  function! ScmStatus()
    if exists('b:git_dir')
      let head = fugitive#head()
      let [added, modified, removed] = GitGutterGetHunkSummary()
      return printf('⌥ (%s) +%d ~%d -%d', head, added, modified, removed)
    endif
    return ''
  endfunction
  function! CwdBase()
    return fnamemodify(getcwd(), ':t')
  endfunction
  set statusline=
  set statusline+=%#identifier#\ %{CwdBase()}\ %*%f
  set statusline+=%m%r
  set statusline+=\ %{ScmStatus()}
  set statusline+=%=
  set statusline+=%y
  set statusline+=┊%P[%c@%l/%L]

  " Tagbar
  nnoremap <leader>t :TagbarOpenAutoClose<cr>

  " NERDTree
  nnoremap <leader>s :NERDTreeToggle<cr>

  " gitgutter
  autocmd BufWritePost * GitGutter

  " Go
  au Filetype go nnoremap <c-k> :GoDef<cr>
  au Filetype go vnoremap <c-k> :GoDef<cr>
  au Filetype go nnoremap <c-l> :GoDefPop<cr>
  au Filetype go vnoremap <c-l> :GoDefPop<cr>
  au BufNewFile,BufRead *.go nnoremap <c-k> :GoDef<cr>
  au BufNewFile,BufRead *.go vnoremap <c-k> :GoDef<cr>
  au BufNewFile,BufRead *.go nnoremap <c-l> :GoDefPop<cr>
  au BufNewFile,BufRead *.go vnoremap <c-l> :GoDefPop<cr>
  let g:go_fmt_fail_silently = 1
  let g:go_fmt_command = "goimports"
  let g:go_fmt_options = {
    \ 'goimports': '-local do/',
    \ }
  let g:go_test_prepend_name = 1
  let g:go_list_type = "quickfix"
  let g:go_auto_type_info = 0
  let g:go_auto_sameids = 0
  let g:go_info_mode = "gocode"

  let g:go_def_mode = "godef"
  let g:go_echo_command_info = 1
  let g:go_autodetect_gopath = 1
  let g:go_metalinter_autosave_enabled = ['vet', 'golint']
  let g:go_metalinter_enabled = ['vet', 'golint']

  let g:go_highlight_space_tab_error = 0
  let g:go_highlight_array_whitespace_error = 0
  let g:go_highlight_trailing_whitespace_error = 0
  let g:go_highlight_extra_types = 0
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_types = 0
  let g:go_highlight_operators = 1
  let g:go_highlight_format_strings = 0
  let g:go_highlight_function_calls = 0
  let g:go_gocode_propose_source = 1

  let g:go_modifytags_transform = 'camelcase'
  let g:go_fold_enable = []

  set completeopt-=preview

  " Markdown
  let g:markdown_fenced_languages = ['html']

  " GLSL
  au BufNewFile,BufRead *.glsl set filetype=glsl
  au BufNewFile,BufRead *.frag set filetype=glsl
  au BufNewFile,BufRead *.vert set filetype=glsl

  " Tabs
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2
  set expandtab
  set smarttab

  " Splits
  set splitbelow
  set splitright

  " Make
  nnoremap <leader>m :echo "Building..."\|make\|redraw\|botright cwindow\|echo "Done!"<cr>

  " C/C++
  let g:clang_format#detect_style_file = 1
  let g:clang_format#auto_formatexpr = 1
  autocmd FileType c ClangFormatAutoEnable
  autocmd FileType cpp ClangFormatAutoEnable
  let g:cpp_class_scope_highlight = 1
  let g:cpp_member_variable_highlight = 1
  let g:cpp_class_decl_highlight = 1

  " Coc
  nnoremap <leader>n :call CocActionAsync('diagnosticNext')<cr>
  nnoremap <leader>f :CocFix<cr>
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gr <Plug>(coc-references)
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

  nnoremap <silent> K :call <SID>show_documentation()<CR>
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Todo highlight
  let g:todo_highlight_config = {
        \   'NOTE': {
        \     'gui_fg_color': '#ffffff',
        \     'gui_bg_color': '#2abdff',
        \     'cterm_fg_color': 'white',
        \     'cterm_bg_color': '214'
        \   }
        \ }

  " Treesitter
lua <<EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = {"c", "cpp", "go", "elm", "html", "javascript", "lua", "typescript"},
    highlight = {
      enable = true,
    },
  }
EOF
endif

" plantuml call
nnoremap <leader>u :! plantuml -tutxt %<cr>
vnoremap <leader>u :'<,'>%! plantuml -tutxt -p<cr>

" graph-easy call
nnoremap <leader>g :! graph-easy --as=boxart %<cr>
vnoremap <leader>g :'<,'>%! graph-easy --as=boxart<cr>

" strikethrough
nnoremap <leader>- :s/./&̶/g<cr>:nohl<cr>

" easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" indent-guide
let g:indentLine_char = '¦'
let g:indentLine_first_char = '¦'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 0
