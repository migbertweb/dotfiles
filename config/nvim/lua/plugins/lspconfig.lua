return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      phpactor = {
        root_dir = require("lspconfig").util.root_pattern("composer.json", ".git"),
        filetypes = { "php" }, -- Limitar solo a archivos PHP, sin incluir .blade.php
        settings = {
          phpactor = {
            filetypes = { "php" }, -- Aquí también puedes limitar los tipos de archivo
            exclude = { "*.blade.php", "blade" }, -- Excluir archivos .blade.php
          },
        },
      },
      tailwindcss = {
        -- exclude a filetype from the default_config
        filetypes_exclude = { "markdown", "php" },
        -- add additional filetypes to the default_config
        filetypes_include = {},
        -- to fully override the default_config, change the below
        -- filetypes = {}
      },
      jsonls = {},
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                vim.fn.expand("$VIMRUNTIME/lua"),
              },
              maxPreload = 100000,
              preloadFileSize = 10000,
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
    },
    diagnostics = {
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    },
    format = {
      formatting_options = nil,
      timeout_ms = 15000,
    },
  },
}
