return {
  -- instalar el servidor LSP para Python
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        pylsp = {
          plugins = {
            pycodestyle = {
              ignore = { 'W391' },
              maxLineLength = 100
            },
          },
        },
      },
    },
  },
  -- null-ls para Diagnostic y Formatting
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          -- Python
          -- nls.builtins.diagnostics.flake8,
          nls.builtins.formatting.autopep8,
          -- Django/Jinja Template
          nls.builtins.formatting.djlint,
          nls.builtins.diagnostics.djlint,
        },
      }
    end,
  },
  -- instalar los linter y Formateadores
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "autopep8",
        "djlint",
        "flake8",
      },
    },
  },
  -- Instalar treesitter Parser para PHP
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "python",
          "htmldjango", })
      end
    end,
  },
}
