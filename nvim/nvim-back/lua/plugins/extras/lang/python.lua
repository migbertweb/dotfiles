return {
  -- instalar el servidor LSP para Python
  {
    "neovim/nvim-lspconfig",
    opts = {
      format = {
        formatting_options = nil,
        timeout_ms = 5000,
      },
      -- make sure mason installs the server
      servers = {
        pyright = {
          settings = {
            python = {
              pythonPath = "/usr/bin/python3",
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true
              }
            }
          },
        },

        -- pylsp = {
        --   plugins = {
        --     pycodestyle = {
        --       ignore = { 'W391', 'E501' },
        --       maxLineLength = 100
        --     },
        --   },
        -- },
      },
    },
  },
  {
    "HallerPatrick/py_lsp.nvim",
    keys =
    {
      {
        "<leader>vl",
        "<cmd>:PyLspFindVenvs<cr>",
        desc = "Find Venvs"
      },
      {
        "<leader>va",
        "<cmd>:PyLspActivateVenv<cr>",
        desc = "Activate Venv"
      },
      {
        "<leader>vd",
        "<cmd>:PyLspDeactivateVenv<cr>",
        desc = "DeActivate Venv"
      },
      {
        "<leader>vr",
        "<cmd>:PyRun<cr>",
        desc = "Run Python Script"
      },
      {
        "<leader>vc",
        "<cmd>:PyLspCreateVenv<cr>",
        desc = "Create Virtual Env"
      }
    },
    opts = {
      host_python = "/usr/bin/python3",
      default_venv_name = ".venv, venv"
    }
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
          -- nls.builtins.formatting.autopep8,
          nls.builtins.formatting.yapf,
          -- Django/Jinja Html Template
          -- nls.builtins.diagnostics.djlint,
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
        "yapf",
        -- "djlint",
        -- "flake8",
      },
    },
  },
  -- Instalar treesitter Parser para Python
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "python",
          "htmldjango" })
      end
    end,
  },
}
