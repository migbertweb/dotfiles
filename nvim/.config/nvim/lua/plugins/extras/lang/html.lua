return {
  -- instalar el servidor LSP para HTML
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        html = {
          filetypes = { "html", "htmldjango", "jinja" },
          init_options = {
            configurationSection = { "html", "css", "javascript" },
            embeddedLanguages = {
              css = true,
              javascript = true
            },
            provideFormatter = true
          }

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
          --  nls.builtins.formatting.tidy,
          -- nls.builtins.formatting.prettierd,
          nls.builtins.diagnostics.tidy,
        },
      }
    end,
  },
  -- Instalar treesitter Parser para HTML
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "html", })
      end
    end,
  },
}
