return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "php" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          settings = {
            intelephense = {
              files = {
                maxSize = 1000000,
              },
            },
          },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    opts = {
      setup = {
        phpdebug = function()
          local dap = require "dap"
          dap.adapters.php = {
            type = "executable",
            command = "node",
            args = { "/home/migbert/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js" },
          }
          dap.configurations.php = {
            {
              type = "php",
              request = "launch",
              name = "Listen for Xdebug",
              port = 9000,
            },
          }
        end,
      },
    },
  },
}
