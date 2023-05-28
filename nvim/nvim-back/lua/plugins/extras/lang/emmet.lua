return {
  -- instalar el servidor LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        emmet_ls = {},
      },
    },
  },
}
