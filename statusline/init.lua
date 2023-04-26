return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      local components = require("plugins.extras.ui.statusline.components")
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          -- component_separators = '',
          -- section_separators = '',
          disabled_filetypes = {
            statusline = { "alpha", "lazy" },
            winbar = {
              "help",
              "alpha",
              "lazy",
            },
          },
          always_divide_middle = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { components.git_repo, "branch" },
          lualine_c = {
            {
              "filetype",
              icon_only = true,
              separator = "",
              padding = {
                left = 1, right = 0 }
            },
            { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
            components.diff,
            -- components.separator,
            -- components.lsp_client,
          },
          lualine_x = { components.noice_mode, components.lsp_client, components.diagnostics, components.spaces, "encoding", "fileformat", "filetype", "progress" },
          lualine_y = {},
          lualine_z = { "location" },
        }, --cambio
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        winbar = {
          lualine_a = {
            {
              function() return require("nvim-navic").get_location() end,
              cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
            },
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
        inactive_winbar = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
        extensions = { "nvim-tree", "toggleterm", "quickfix" },
      })
    end,
  },
}
