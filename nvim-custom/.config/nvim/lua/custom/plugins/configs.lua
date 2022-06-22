-- custom/plugins/configs.lua file

local M = {}

M.treesitter = {
   ensure_installed = {
      "lua",
      "html",
      "css",
      "php",
      "json",
      "http",
      "python",
      "bash",
      "javascript",
      "typescript",
   },
}

M.nvimtree = {
   git = {
      enable = true,
   },
   view = {
      width = 25,
   },
   renderer = {
      highlight_git = true,
      icons = {
         show = {
            git = true,
         },
      },
   },
}
return M
