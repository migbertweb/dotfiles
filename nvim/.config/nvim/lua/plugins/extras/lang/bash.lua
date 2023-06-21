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
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "mason.nvim" },
        opts = function()
          local nls = require("null-ls")
          return {
            root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
            sources = {
              -- nls.builtins.formatting.fish_indent,
              -- nls.builtins.diagnostics.fish,
              nls.builtins.formatting.stylua,
              nls.builtins.formatting.beautysh,
              -- nls.builtins.formatting.shfmt,
              -- nls.builtins.diagnostics.flake8,
            },
          }
        end,
      },
    -- instalar los linter y Formateadores
    {
      "williamboman/mason.nvim",
      opts = function(_, opts)
        table.insert(opts.ensure_installed, "beautysh")
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