return {
  "akinsho/toggleterm.nvim",
 keys = {
    --{ [[<C-\>]] },
    { "<leader>0", "<Cmd>2ToggleTerm<Cr>", desc = "Terminal #2" },
  },
  cmd = { "ToggleTerm", "TermExec" },
  opts = {
    size = 12,
    hide_numbers = true,
    open_mapping = [[<C-\>]],
    shade_filetypes = {},
    shade_terminals = false,
    shading_factor = 0.3,
    start_in_insert = true,
    persist_size = true,
    direction = "horizontal", -- "float",
    float_opts = {
      border = "curved", -- | ... other options supported by win open
    },
    winbar = {
      enabled = false,
      name_formatter = function(term)
        return term.name
      end,
    },
  },
}

