set nocompatible
filetype plugin on

let mapleader=','

" Vundle
if has('win32')
  set rtp+=~/AppData/Local/nvim/bundle/Vundle.vim
  call vundle#begin('~/AppData/Local/nvim/bundle')
else
  set rtp+=~/.config/nvim/bundle/Vundle.vim
  call vundle#begin('~/.config/nvim/bundle')
endif
Plugin 'VundleVim/Vundle.vim'

" Vim settings/improvements
Plugin 'nanotech/jellybeans.vim'
Plugin 'lifepillar/vim-solarized8'
Plugin 'morhetz/gruvbox'
Plugin 'nazo/pt.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'mhinz/vim-signify'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'w0rp/ale'
Plugin 'mattn/emmet-vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'KabbAmine/zeavim.vim'
Plugin 'jodosha/vim-godebug'
Plugin 'ryanoasis/vim-devicons'
Plugin 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'build': 'bash install.sh',
  \ }
Plugin 'Shougo/deoplete.nvim', { 'build': ':UpdateRemotePlugins' }
Plugin 'Shougo/neosnippet.vim'

" File and syntax
Plugin 'vimwiki/vimwiki'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'gabrielelana/vim-markdown'
Plugin 'petrbroz/vim-glsl'
Plugin 'rhysd/vim-clang-format'
Plugin 'rust-lang/rust.vim'
Plugin 'cespare/vim-toml'
Plugin 'tpope/vim-fugitive'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'fatih/vim-go'
Plugin 'jansedivy/jai.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'lifepillar/pgsql.vim'
Plugin 'shime/vim-livedown'
Plugin 'aklt/plantuml-syntax'

call vundle#end()

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

" Deoplete
let g:deoplete#enable_at_startup=1

" LanguageClient
let g:LanguageClient_rootMarkers = {
        \ 'go': ['.git', 'go.mod'],
        \ }

let g:LanguageClient_serverCommands = {
    \ 'go': ['bingo'],
    \ }

function LC_maps()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
  endif
endfunction
autocmd FileType * call LC_maps()

" Neosnippet
let g:neosnippet#disable_runtime_snippets={
      \ '_' : 1,
      \ }
let g:neosnippet#snippets_directory='~/.config/nvim/snippets'
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" plantuml call
nnoremap <leader>u :! plantuml -tutxt %<cr>
vnoremap <leader>u :'<,'>%! plantuml -tutxt -p<cr>

" graph-easy call
nnoremap <leader>g :! graph-easy --as=boxart %<cr>
vnoremap <leader>g :'<,'>%! graph-easy --as=boxart<cr>

" Eyecandy
set cursorline
set termguicolors
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='soft'
let g:gruvbox_vert_split='bg1'
set background=light
color solarized8_high
set fillchars=vert:\ 

function! ToggleBackground()
  if &background ==# 'dark'
    set background=light
    color solarized8_high
  else
    set background=dark
    color gruvbox
  endif
endfunction
nnoremap <f2> :call ToggleBackground()<cr>
if !empty($DARK)
  call ToggleBackground()
endif

" Searching
nnoremap <leader><leader> :nohl<cr>

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
  let head = '-'
  if exists('b:git_dir')
    let head = fugitive#head()
  endif
  return '⌥('.head.')'
endfunction
set statusline=
set statusline+=[%n]\ %f
set statusline+=%m%r
set statusline+=\ %{ScmStatus()}
set statusline+=%=
set statusline+=%y
set statusline+=┊%P[%c@%l/%L]

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
let g:livedown_autorun = 0
let g:livedown_open = 1
let g:livedown_port = 1337
let g:livedown_browser = "firefox"
au Filetype markdown nnoremap <c-p> :LivedownToggle<cr>
au Filetype markdown vnoremap <c-p> :LivedownToggle<cr>

" GLSL
au BufNewFile,BufRead *.glsl set filetype=glsl
au BufNewFile,BufRead *.frag set filetype=glsl
au BufNewFile,BufRead *.vert set filetype=glsl

" NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeShowLineNumbers = 1
let NERDTreeMapOpenSplit = 's'
let NERDTreeMapOpenPreviewSplit = 'gs'
let NERDTreeMapOpenVSplit = 'i'
let NERDTreeMapOpenPreviewVSplit = 'gi'
let NERDTreeShowHidden = 1
nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>f :NERDTreeFind<cr>

" Tagbar
nnoremap <leader>t :TagbarToggle<cr>

" Tabs
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab

" Splits
set splitbelow
set splitright
nnoremap <c-y> :vert res +10<cr>
nnoremap <c-o> :vert res -10<cr>

" Make
nnoremap <leader>m :silent make\|redraw\|cwindow<cr>
nnoremap <leader>b :GoBuild<cr>

" Clang format
let g:clang_format#style_options = {
  \ 'AccessModifierOffset': -4,
  \ 'AlignAfterOpenBracket': 'DontAlign',
  \ 'AlignConsecutiveAssignments': 'false',
  \ 'AlignOperands': 'true',
  \ 'AlignTrailingComments': 'false',
  \ 'AllowAllParametersOfDeclarationOnNextLine': 'false',
  \ 'AllowShortBlocksOnASingleLine': 'false',
  \ 'AllowShortCaseLabelsOnASingleLine': 'false',
  \ 'AllowShortFunctionsOnASingleLine': 'None',
  \ 'AllowShortIfStatementsOnASingleLine': 'false',
  \ 'AllowShortLoopsOnASingleLine': 'false',
  \ 'AlwaysBreakAfterReturnType': 'None',
  \ 'AlwaysBreakTemplateDeclarations': 'false',
  \ 'BinPackArguments': 'true',
  \ 'BinPackParameters': 'true',
  \ 'BreakBeforeBinaryOperators': 'NonAssignment',
  \ 'BreakBeforeBraces': 'Custom',
  \ 'BraceWrapping': {
    \ 'AfterClass': 'false',
    \ 'AfterControlStatement': 'false',
    \ 'AfterEnum': 'false',
    \ 'AfterFunction': 'false',
    \ 'AfterNamespace': 'false',
    \ 'AfterObjCDeclaration': 'false',
    \ 'AfterStruct': 'false',
    \ 'AfterUnion': 'false',
    \ 'BeforeCatch': 'false',
    \ 'BeforeElse': 'false',
    \ 'IndentBraces': 'false',
    \ },
  \ 'BreakBeforeTernaryOperators': 'true',
  \ 'ColumnLimit': 0,
  \ 'ContinuationIndentWidth': 2,
  \ 'Cpp11BracedListStyle': 'false',
  \ 'DerivePointerAlignment': 'false',
  \ 'IndentCaseLabels': 'true',
  \ 'IndentWidth': 2,
  \ 'IndentWrappedFunctionNames': 'false',
  \ 'KeepEmptyLinesAtTheStartOfBlocks': 'false',
  \ 'MaxEmptyLinesToKeep': 1,
  \ 'PointerAlignment': 'Right',
  \ 'SpaceAfterCStyleCast': 'false',
  \ 'SpaceBeforeAssignmentOperators': 'true',
  \ 'SpaceBeforeParens': 'ControlStatements',
  \ 'SpaceInEmptyParentheses': 'false',
  \ 'SpacesInCStyleCastParentheses': 'false',
  \ 'SpacesInContainerLiterals': 'false',
  \ 'SpacesInParentheses': 'false',
  \ 'SpacesInSquareBrackets': 'false',
  \ 'Standard': 'Cpp11',
  \ 'UseTab': 'Never',
  \ }
let g:clang_format#detect_style_file = 1
let g:clang_format#auto_formatexpr = 1
" autocmd FileType c ClangFormatAutoEnable

" Rust
let g:rustfmt_autosave = 1

" Time func
let g:time_stamp_enabled = 0
command! TimeStampToggle let g:time_stamp_enabled = !g:time_stamp_enabled

inoremap <expr> <CR> g:time_stamp_enabled ? "\<ESC>:call TimeStamp()\<CR>a" : "\<CR>"

function! TimeStamp()
  let l:current_time = strftime("%H:%M:%S")
  execute "normal! 0i\<SPACE>\<ESC>0dwi\
    \<C-R>=l:current_time\<CR>\
    \<SPACE>\<SPACE>—\<SPACE>\<SPACE>\<ESC>o\<SPACE>\<SPACE>\<SPACE>\<SPACE>\
    \<SPACE>\<SPACE>\<SPACE>\<SPACE>\<SPACE>\<SPACE>\<SPACE>\<SPACE>\<SPACE>"
endfunction
