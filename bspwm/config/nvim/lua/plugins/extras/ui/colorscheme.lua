return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false,
      terminal_colors = true,
    },
  },
  -- config colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-moon",
    },
  },
}
