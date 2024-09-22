return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- @type lspconfig.options
      servers = {
        emmet_ls = {
          filetypes = {
            "astro",
            "blade",
            "css",
"json",
            "eruby",
            "html",
            "htmldjango",  
          "javascript",
            "javascriptreact",
            "less",
            "pug",
            "sass",
            "scss",
            "svelte",
            "typescriptreact",  
          "typescript",
            "vue",
          },
        },
      },
    },
  },
}
