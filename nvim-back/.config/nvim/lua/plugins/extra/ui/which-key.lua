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
                border = "double", -- none, single, double, shadow
                position = "bottom", -- bottom, top
                margin = { 2, 2, 1, 2 }, -- extra window margin [top, right, bottom, left]
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
              ["<leader>b"] = { name = "  buffer" },
              ["<leader>c"] = { name = "  code" },
              ["<leader>f"] = { name = "  file/find" },
              ["<leader>g"] = { name = "  git" },
              ["<leader>gh"] = { name = "  hunks" },
              ["<leader>q"] = { name = "  quit/session" },
              ["<leader>s"] = { name = "  search" },
              ["<leader>sn"] = { name = "  noice" },
              ["<leader>u"] = { name = "  ui" },
              ["<leader>w"] = { name = "  windows" },
              ["<leader>x"] = { name = "  diagnostics/quickfix" },
              ["<leader>r"] = { name = " Rest-nvim" },
              ["<leader>d"] = { name = " Database" },
          })
        end,
    }
}
