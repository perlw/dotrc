call plug#begin('~/.config/nvim/bundle')

" Vim settings/improvements
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'ntpeters/vim-better-whitespace'
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
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-sensible'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'MunifTanjim/nui.nvim', { 'branch': 'main' }
Plug 'nvim-neo-tree/neo-tree.nvim', { 'branch': 'main' }
" Style/sexy
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ellisonleao/gruvbox.nvim', { 'branch': 'main' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'prettier/vim-prettier', { 'do': 'npm install --production' }
Plug 'airblade/vim-gitgutter', { 'branch': 'main' }
" File and syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'sheerun/vim-polyglot'
Plug 'rhysd/vim-clang-format'
Plug 'fatih/vim-go'
Plug 'hashivim/vim-terraform'
Plug 'folke/todo-comments.nvim', { 'branch': 'main' }
" Others
Plug 'wakatime/vim-wakatime'

call plug#end()
