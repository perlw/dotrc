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
  Plug 'ryanoasis/vim-devicons'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'tpope/vim-vinegar'
  Plug 'sakshamgupta05/vim-todo-highlight'
  Plug 'preservim/nerdtree'
  Plug 'preservim/tagbar'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'
  Plug 'glepnir/lspsaga.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  " Style/sexy
  Plug 'ayu-theme/ayu-vim'
  " File and syntax
  Plug 'gabrielelana/vim-markdown'
  Plug 'petrbroz/vim-glsl'
  Plug 'rhysd/vim-clang-format'
  Plug 'tpope/vim-fugitive'
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
  Plug 'fatih/vim-go'
  Plug 'jansedivy/jai.vim'
  Plug 'leafgarland/typescript-vim'
  Plug 'lifepillar/pgsql.vim'
  Plug 'aklt/plantuml-syntax'
  Plug 'PProvost/vim-ps1'
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

  " Autoreload changed files
  " https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
  set autoread
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
        \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
  autocmd FileChangedShellPost *
        \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

  " local vim config support
  silent! so .vimlocal

  " netrw
  let g:netrw_bufsettings = 'noma nomod nu nowrap ro nobl'

  " Eyecandy
  set cursorline
  autocmd WinEnter,BufEnter,BufWinEnter * set cursorline
  autocmd WinLeave,BufLeave,BufWinLeave * set nocursorline
  set termguicolors
  let ayucolor="mirage"
  color ayu
  set fillchars=vert:\│
  hi! VertSplit guifg=darkgray

  " Statusline
  function! InsertStatuslineColor(mode)
    if a:mode ==? 'i'
      hi User1 ctermbg=darkgreen guibg=darkgreen
      hi User2 ctermfg=darkgreen guifg=darkgreen
    elseif a:mode ==? 'r'
      hi User1 ctermbg=darkmagenta guibg=darkmagenta
      hi User2 ctermfg=darkmagenta guifg=darkmagenta
    else
      hi User1 ctermbg=red guibg=red
      hi User2 ctermfg=red guifg=red
    endif
  endfunction
  function! InitialStatuslineColors()
    hi statusline ctermbg=grey ctermfg=yellow guibg=grey guifg=yellow
    hi User1 ctermbg=darkgrey ctermfg=yellow guibg=darkgrey guifg=yellow
    hi User2 ctermbg=gray ctermfg=darkgrey guibg=grey guifg=darkgrey
  endfunction
  au InsertEnter * call InsertStatuslineColor(v:insertmode)
  au InsertChange * call InsertStatuslineColor(v:insertmode)
  au InsertLeave * call InitialStatuslineColors()
  call InitialStatuslineColors()

  function! ScmBranch()
    if exists('b:git_dir')
      let head = fugitive#head()
      if len(head) > 30
        let head = head[0:27] . "..."
      endif
      return printf('%s', head)
    endif
    return ''
  endfunction
  function! CwdBase()
    return fnamemodify(getcwd(), ':t')
  endfunction

  set statusline=
  set statusline+=%1*\ %{CwdBase()}\ %2*%*\ %t
  set statusline+=%m%r
  set statusline+=\ %{ScmBranch()}
  set statusline+=%=
  set statusline+=%2*%1*\ %y
  set statusline+=\ %c#%l/%L\ %*

  " Tagbar
  nnoremap <leader>t :TagbarOpenAutoClose<cr>

  " NERDTree
  nnoremap <leader>s :NERDTreeToggle<cr>

  " gitgutter
  autocmd BufWritePost * GitGutter
  set signcolumn=yes
  let g:gitgutter_highlight_linenrs=1
  let g:gitgutter_async=1

  " Go
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

  " compe
  inoremap <silent><expr> <C-Space> compe#complete()
  inoremap <silent><expr> <CR>      compe#confirm('<CR>')
  inoremap <silent><expr> <C-e>     compe#close('<C-e>')
  inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
  inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
lua <<EOF
  vim.o.completeopt = "menuone,noselect"
  require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;
    source = {
      path = true;
      buffer = true;
      calc = true;
      tags = true;
      nvim_lsp = true;
      nvim_lua = true;
      emoji = true;
      --vsnip = true;
      --ultisnips = true;
    };
  }
EOF

  " saga
  nnoremap <silent><leader>cd <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>
  nnoremap <silent><leader>cc <cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>
  nnoremap <silent><leader>gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
  nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
  vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
  nnoremap <silent><leader>p <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
  nnoremap <silent><leader>n <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>
  nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
  nnoremap <silent> gr <cmd>lua require('lspsaga.rename').rename()<CR>
  nnoremap <silent> gd <cmd>lua require'lspsaga.provider'.preview_definition()<CR>
  nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
  nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
  nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
lua <<EOF
  require('lspsaga').init_lsp_saga()
EOF

  " Todo highlight
  let g:todo_highlight_config = {
        \   'NOTE': {
        \     'gui_bg_color': '#2abdff',
        \     'cterm_bg_color': '214'
        \   },
        \   'FIXME': {
        \     'gui_bg_color': '#d35b5b',
        \     'cterm_bg_color': 'red'
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

  " lspconfig
lua <<EOF
  local nvim_lsp = require('lspconfig')
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    --Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  end

  local servers = { "clangd", "gopls", "tsserver" }
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup { on_attach = on_attach }
  end

  nvim_lsp.diagnosticls.setup {
    on_attach = on_attach,
    filetypes = vim.tbl_keys({
      javascript = "eslint",
      javascriptreact = "eslint",
      typescript = "eslint",
      typescriptreact = "eslint"
    }),
    init_options = {
      filetypes = {
        javascript = "eslint",
        javascriptreact = "eslint",
        typescript = "eslint",
        typescriptreact = "eslint"
      },
      linters = {
        eslint = {
          sourceName = "eslint",
          command = "./node_modules/.bin/eslint",
          rootPatterns = {".git"},
          debounce = 100,
          args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
          parseJson = {
            errorsRoot = "[0].messages",
            line = "line",
            column = "column",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "${message} [${ruleId}]",
            security = "severity"
          },
          securities = {[2] = "error", [1] = "warning"}
        }
      }
    }
  }
EOF

  " telescope
  nnoremap <leader>ff <cmd>Telescope find_files<cr>
  nnoremap <leader>fg <cmd>Telescope live_grep<cr>
  nnoremap <leader>fb <cmd>Telescope buffers<cr>
  nnoremap <leader>fh <cmd>Telescope help_tags<cr>
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
