set nocompatible
filetype off

" Vundle
if has('win32')
  set rtp+=~/AppData/Local/nvim/bundle/Vundle.vim
  call vundle#begin('~/AppData/Local/nvim/bundle')
else
  set rtp+=~/.config/nvim/bundle/Vundle.vim
  call vundle#begin('~/.config/nvim/bundle')
endif

Plugin 'VundleVim/Vundle.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'mileszs/ack.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'mhinz/vim-signify'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'tpope/vim-speeddating'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'vimwiki/vimwiki'

Plugin 'mustache/vim-mustache-handlebars'
Plugin 'tpope/vim-markdown'
Plugin 'petrbroz/vim-glsl'
Plugin 'rhysd/vim-clang-format'
Plugin 'rust-lang/rust.vim'
Plugin 'cespare/vim-toml'
Plugin 'tpope/vim-fugitive'

call vundle#end()

" Generic settings
set enc=utf-8
set relativenumber
set number
set nowrap
au InsertEnter * :set norelativenumber
au InsertLeave * set number | :set relativenumber
au FileType make set noexpandtab
au FileType rust set ts=2 sw=2 sts=2
au FileType c set ts=2 sw=2 sts=2
au BufRead,BufNewFile *.rs set ts=2 sw=2 sts=2
au BufRead,BufNewFile *.c set ts=2 sw=2 sts=2
au BufRead,BufNewFile *.h set ts=2 sw=2 sts=2
set nobackup
set noswapfile
set mouse=n
set path+=**
set wildmenu
filetype indent plugin on
syn on

" Statusline
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline ctermbg=magenta guibg=magenta cterm=NONE gui=NONE
  elseif a:mode == 'r'
    hi statusline ctermbg=blue guibg=blue cterm=NONE gui=NONE
  else
    hi statusline ctermbg=red guibg=red cterm=NONE gui=NONE
  endif
endfunction
au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertChange * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline ctermbg=green guibg=green cterm=NONE gui=NONE
hi statusline ctermbg=green guibg=green cterm=NONE gui=NONE

set statusline=
set statusline+=[%n]%f
set statusline+=%m%r
set statusline+=\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}
set statusline+=%=
set statusline+=%y
set statusline+=%P[%l/%L]

" Tags
"autocmd BufWritePost *.c,*.cpp,*.php,*.js,*.html silent! !ctags -a -R % &
function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let cmd = 'ctags -a ' . f
  call DelTagOfFile(f)
  let resp = system(cmd)
endfunction
autocmd BufWritePost *.c,*.cpp,*.php,*.js,*.html call UpdateTags()
nnoremap <c-k> g<c-]>
vnoremap <c-k> g<c-]>

" Markdown
let g:markdown_fenced_languages = ['html']

" GLSL
au BufNewFile,BufRead *.glsl set filetype=glsl
au BufNewFile,BufRead *.frag set filetype=glsl
au BufNewFile,BufRead *.vert set filetype=glsl

" Remap terminal escape
tnoremap <Esc> <C-\><C-n>

" Paste with indentation
nnoremap p p=`[

" 'Normal' copy/paste
nnoremap <C-X> "+x
inoremap <C-X> "+x
vnoremap <C-X> "+x
nnoremap <C-C> "+y
inoremap <C-C> "+y
vnoremap <C-C> "+y
nnoremap <C-V> "+p=`[
inoremap <C-V> "+p=`[
vnoremap <C-V> "+p=`[

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
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab

" Splits
set splitbelow
set splitright

let mapleader=','

" Make
nnoremap <Leader>m :silent make\|redraw\|cwindow<CR>

" jsx
let g:jsx_ext_required = 1

" Eyecandy
set cursorline
if has('gui_running')
  set guifont=PragmataPro_Mono:h9

	" Turning off scrollbars
	set guioptions-=r
	set guioptions-=R
	set guioptions-=l
	set guioptions-=L
  set guioptions-=T
  set guioptions-=m
endif

color jellybeans
set fillchars=vert:\ 
hi NonText guifg=bg

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
autocmd FileType c ClangFormatAutoEnable

" Editorconfig
let g:EditorConfig_core_mode = "python_builtin"