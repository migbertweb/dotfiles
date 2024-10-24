local TelescopePrompt = {
  TelescopeNormal = { bg = "#222430" },
  TelescopeBorder = {
    fg = "#222430",
    bg = "#222430",
  },
  TelescopePromptNormal = {
    fg = "#F8F8F2",
    bg = "#2d303e",
  },
  TelescopePromptBorder = {
    fg = "#2d303e",
    bg = "#364649",
  },
  TelescopePromptTitle = {
    fg = "#282A36",
    bg = "#F07167",
  },
  TelescopePreviewTitle = {
    fg = "#282A36",
    bg = "#0081A7",
  },
  TelescopeResultsTitle = {
    fg = "#00AFB9",
    bg = "#222430",
  },
}
for hl, col in pairs(TelescopePrompt) do
  vim.api.nvim_set_hl(0, hl, col)
end
return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        results_title = false,
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        borderchars = { " " },
        color_devicons = true,
      },
    },
  },

  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  {
    "telescope.nvim",
    keys = {
      { "<leader>C", "<cmd>:Telescope conventional_commits<cr>", desc = "+Conventional Commit" },
    },
    dependencies = {
      "olacin/telescope-cc.nvim",
      config = function()
        require("telescope").load_extension("conventional_commits")
      end,
    },
  },
  {
    "telescope.nvim",
    keys = {
      { "<C-n>", "<cmd>:Telescope file_browser<cr>", desc = "File Browser" },
    },
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      config = function()
        require("telescope").load_extension("file_browser")
      end,
    },
  },
}
