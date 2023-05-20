return {
  -- null-ls para Diagnostic y Formatting
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          nls.builtins.formatting.prettierd,
        },
      }
    end,
  },
  -- instalar los linter y Formateadores
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "prettierd", "prettier"
      },
    },
  },
}
