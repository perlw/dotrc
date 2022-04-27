lua <<EOF
  require 'nvim-treesitter.install'.compilers = { "clang" }
  require 'nvim-treesitter.configs'.setup {
    ensure_installed = {
      "bash",
      "c",
      "cmake",
      "cpp",
      "css",
      "glsl",
      "go",
      "gomod",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "latex",
      "llvm",
      "lua",
      "php",
      "phpdoc",
      "regex",
      "typescript",
      "toml",
      "tsx",
      "vim",
      "yaml",
      "zig",
    },
    highlight = {
      enable = true,
    },
  }
EOF
