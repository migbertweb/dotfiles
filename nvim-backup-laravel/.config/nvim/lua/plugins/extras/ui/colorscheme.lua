return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
    },
  },
  -- -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  -- Add dracula
  {
    "Mofiqul/dracula.nvim",
    opts = {
      italic_comment = true,
    },
  },
  -- add vscode theme
  {
    "Mofiqul/vscode.nvim",
    opts = {
      transparent = true,
      italic_comment = true,
    },
  },
  -- add Monokai-pro theme
  {
    "https://gitlab.com/__tpb/monokai-pro.nvim",
  },
  -- add Tokyodark
  {
    "tiagovla/tokyodark.nvim",
    config = function()
      vim.g.tokyodark_enable_italic_comment = true
      vim.g.tokyodark_enable_italic = true
      vim.g.tokyodark_color_gamma = "0.8"
    end,
  },
  { 
  "rose-pine/neovim",
  name = "rose-pine"
  },
  { "EdenEast/nightfox.nvim" },
  -- config colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
