lua <<EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "vim", "help", "bash", "cmake", "css", "diff", "gitcommit", "gitignore", "go", "gomod", "html", "http", "java", "javascript", "jq", "json5", "jsdoc", "lua", "markdown", "scss", "sql", "terraform", "typescript", "yaml" },

    sync_install = false,
    auto_install = true,

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  }
EOF
