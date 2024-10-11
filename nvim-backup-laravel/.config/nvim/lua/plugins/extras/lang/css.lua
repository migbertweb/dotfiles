return {
  "neovim/nvim-lspconfig",
  opts = {
    -- make sure mason installs the server
    servers = {
      cssls = {},
      cssmodules_ls = {},
    },
  },
}
