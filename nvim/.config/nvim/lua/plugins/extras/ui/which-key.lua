return {
  {
    "folke/which-key.nvim",
    opts = {
      plugins = {
        spelling = true,
      },
      icons = {
        group = "", -- symbol prepended to a group
      },
      window = {
        border = "double",        -- none, single, double, shadow
        position = "bottom",      -- bottom, top
        margin = { 2, 2, 1, 2 },  -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register({
        ["g"] = { name = "  goto" },
        ["gz"] = { name = "  surround" },
        ["]"] = { name = "  next" },
        ["["] = { name = "  prev" },
        ["<leader><tab>"] = { name = " tabs" },
        ["<leader>b"] = { name = "  Buffer" },
        ["<leader>c"] = { name = "  Code" },
        ["<leader>f"] = { name = "  File/find" },
        ["<leader>g"] = { name = "  Git" },
        ["<leader>gh"] = { name = "  hunks" },
        ["<leader>q"] = { name = "  quit/session" },
        ["<leader>s"] = { name = "  Search" },
        ["<leader>sn"] = { name = "  noice" },
        ["<leader>u"] = { name = "  Ui" },
        ["<leader>v"] = { name = "  Python Venv" },
        ["<leader>t"] = { name = "󰆍  Terminal Gui" },
        ["<leader>w"] = { name = "  Windows" },
        ["<leader>x"] = { name = "  Diagnostics/quickfix" },
        ["<leader>r"] = { name = "󱂛  Rest-nvim" },
        ["<leader>d"] = { name = "  Database" },
        ["<leader>m"] = { name = "  Flutter Tools" },
      })
    end,
  }
}
