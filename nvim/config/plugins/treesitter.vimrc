lua <<EOF
  require 'nvim-treesitter.install'.compilers = { "clang" }
  require 'nvim-treesitter.configs'.setup {
    ensure_installed = {"c", "cpp", "go", "elm", "html", "javascript", "json", "lua", "typescript", "vim", "zig"},
    highlight = {
      enable = true,
    },
  }
EOF
