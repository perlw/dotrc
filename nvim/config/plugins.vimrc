call plug#begin('~/.config/nvim/bundle')

if !exists('g:vscode')
  " Vim settings/improvements
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-speeddating'
  Plug 'tpope/vim-surround'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'tpope/vim-vinegar'
  Plug 'sakshamgupta05/vim-todo-highlight'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'rafamadriz/friendly-snippets', { 'branch': 'main' }
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'
  Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'mhinz/vim-startify'
  " Style/sexy
  Plug 'ayu-theme/ayu-vim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'sonph/onehalf', { 'rtp': 'vim' }
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
