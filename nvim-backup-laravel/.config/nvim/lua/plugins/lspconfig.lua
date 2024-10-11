return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      jsonls = {},
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = false,
                [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = false,
                [vim.fn.stdpath("data") .. "/lazy/LazyVim/lua/lazyvim"] = false,
                [vim.fn.stdpath("data") .. "/lazy"] = false,
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
