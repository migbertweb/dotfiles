local colors = {
  bg = "#202328",
  fg = "#bbc2cf",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
}

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      local icons = require("lazyvim.config").icons
      local Util = require("lazyvim.util")
      local components = require("plugins.extras.ui.statusline.components")

      return {
        options = {
          icons_enabled = true,
          component_separators = {},
          section_separators = {},
          theme = {
            normal = {
              a = { fg = colors.fg, bg = colors.bg },
              b = { fg = colors.fg, bg = colors.bg },
              z = { fg = colors.fg, bg = colors.bg },
            },
            inactive = { a = { fg = colors.fg, bg = colors.bg } },
          },
          globalstatus = true,
          disabled_filetypes = {
            statusline = { "dashboard", "alpha" },
            winbar = { "dashboard", "alpha" },
          },
        },
        sections = {
          lualine_a = {
            {
              function()
                return "▊"
              end,
              color = { fg = colors.blue }, -- Sets highlighting of component
              padding = { left = 0, right = 1 }, -- We don't need space before this
            },
            components.mode_evil,
          },
          lualine_b = {
            {
              function()
                return vim.g.remote_neovim_host and ("Remote: %s"):format(vim.uv.os_gethostname()) or ""
              end,
              padding = { right = 1, left = 1 },
              separator = { left = "", right = "" },
            },
            "branch",
            components.diagnostics,
            components.flutter,
          },
          lualine_c = {
            {
              "filetype",
              icon_only = true,
              separator = "",
              padding = {
                left = 1,
                right = 0,
              },
            },
            {
              "filename",
              shorting_target = 20,
              path = 0,
              symbols = { modified = "  ", readonly = "", unnamed = "" },
            },
          },
          lualine_x = {
            components.lsp_client,
            components.separator,
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = Util.ui.fg("Statement"),
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = Util.ui.fg("Constant"),
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = Util.ui.fg("Debug"),
            },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = Util.ui.fg("Special"),
            },
          },
          lualine_y = {
            LazyVim.lualine.cmp_source("codeium"),
          },
          lualine_z = {
            components.spaces,
            components.position,
            { "progress", separator = "", padding = { left = 1, right = 0 } },
            { "encoding" },
            { "fileformat" },
            {
              function()
                return vim.api.nvim_get_option_value("filetype", { buf = 0 })
              end,
            },
            components.venv,
            components.liveserver,
            {
              function()
                return "▊"
              end,
              color = { fg = colors.blue }, -- Sets highlighting of component
              padding = { left = 1, right = 0 }, -- We don't need space before this
            },
            -- function()
            --   return " " .. os.date("%R")
            -- end,
          },
        },
        winbar = {
          lualine_a = {
            {
              "filename",
              path = 3,
              file_status = false,
            },
            {
              function()
                local opts = {
                  separator = "  ",
                }
                return "=> " .. require("nvim-navic").get_location(opts)
              end,
              cond = function()
                return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
              end,
            },
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        inactive_winbar = {},
        extensions = { "nvim-tree", "neo-tree", "lazy", "toggleterm", "trouble" },
      }
    end,
  },
}
