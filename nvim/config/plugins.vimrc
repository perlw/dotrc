call plug#begin('~/.config/nvim/bundle')

" Vim settings/improvements
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'editorconfig/editorconfig-vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'folke/todo-comments.nvim', { 'branch': 'main' }
Plug 'rafamadriz/friendly-snippets', { 'branch': 'main' }
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'mhinz/vim-startify'
Plug 'kshenoy/vim-signature'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'prettier/vim-prettier', { 'do': 'npm install --production' }
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-sensible'
" Style/sexy
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ellisonleao/gruvbox.nvim', { 'branch': 'main' }
" File and syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'sheerun/vim-polyglot'
Plug 'rhysd/vim-clang-format'
Plug 'fatih/vim-go'
Plug 'hashivim/vim-terraform'
" Others
Plug 'wakatime/vim-wakatime'

call plug#end()
