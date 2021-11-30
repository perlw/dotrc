lua <<EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = {"c", "cpp", "go", "elm", "html", "javascript", "lua", "typescript", "zig"},
    highlight = {
      enable = true,
    },
  }
EOF
