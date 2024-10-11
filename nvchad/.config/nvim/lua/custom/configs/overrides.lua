local M = {}

M.lspconfig = {
  format = {
    timeout_ms = 10000,
  },
}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "php",
    "dockerfile",
    "python",
    "htmldjango",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- LSP Servers
    "pyright",
    "intelephense",
    "emmet-ls",
    "dockerfile-language-server",
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
    "phpcbf",
    "phpcs",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- Python
    "yapf",

    -- Docker
    "hadolint",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
