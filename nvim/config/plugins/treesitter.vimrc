lua <<EOF
  require 'nvim-treesitter.install'.compilers = { "clang" }
  require 'nvim-treesitter.configs'.setup {
    ensure_installed = {
      "bash",
      "c",
      "cmake",
      "cpp",
      "css",
      "gitignore",
      "glsl",
      "go",
      "gomod",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "json5",
      "jsonc",
      "latex",
      "llvm",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "regex",
      "sql",
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
