return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        pyright = {
          settings = {
            python = {
              pythonPath = "/usr/bin/python",
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
      },
    },
  },
  -- null-ls para Diagnostic y Formatting
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      table.insert(opts.sources, nls.builtins.formatting.yapf)
    end,
  },
  -- instalar los linter y Formateadores
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "yapf")
    end,
  },
  {
    "HallerPatrick/py_lsp.nvim",
    keys = {
      {
        "<leader>vl",
        "<cmd>:PyLspFindVenvs<cr>",
        desc = "Find Venvs",
      },
      {
        "<leader>va",
        "<cmd>:PyLspActivateVenv<cr>",
        desc = "Activate Venv",
      },
      {
        "<leader>vd",
        "<cmd>:PyLspDeactivateVenv<cr>",
        desc = "DeActivate Venv",
      },
      {
        "<leader>vr",
        "<cmd>:PyRun<cr>",
        desc = "Run Python Script",
      },
      {
        "<leader>vc",
        "<cmd>:PyLspCreateVenv<cr>",
        desc = "Create Virtual Env",
      },
    },
    opts = {
      host_python = "/usr/bin/python3",
      default_venv_name = ".venv, venv",
    },
  },
}
