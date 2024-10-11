return {
    -- instalar el servidor LSP
    {
      "neovim/nvim-lspconfig",
      opts = {
        -- make sure mason installs the server
        servers = {
          bashls = {},
        },
      },
    },
    -- null-ls para Diagnostic y Formatting
    {
        "nvimtools/none-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "mason.nvim" },
        opts = function()
          local nls = require("null-ls")
          return {
            root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
            sources = {
              nls.builtins.formatting.stylua,
            },
          }
        end,
      },
    -- Instalar treesitter Parser
    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          vim.list_extend(opts.ensure_installed, { "bash" })
        end
      end,
    },
  }
