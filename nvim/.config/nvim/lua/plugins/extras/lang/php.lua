return {
  -- instalar el servidor LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- phpactor = {},
        intelephense = {},
      },
    },
  },
  -- null-ls para Diagnostic y Formatting
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      -- table.insert(opts.sources, nls.builtins.diagnostics.phpcs.with({ extra_args = { "--standard=PSR12" } }))
      -- table.insert(opts.sources, nls.builtins.formatting.phpcsfixer.with({ extra_args = { "--rules=@PSR12" } }))
      table.insert(opts.sources, nls.builtins.formatting.pint)
    end,
  },
  -- instalar los linter y Formateadores
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      -- table.insert(opts.ensure_installed, "phpcs")
      -- table.insert(opts.ensure_installed, "php-cs-fixer")
      table.insert(opts.ensure_installed, "pint")
    end,
  },
  -- Instalar treesitter Parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "php" })
      end
    end,
  },
}
