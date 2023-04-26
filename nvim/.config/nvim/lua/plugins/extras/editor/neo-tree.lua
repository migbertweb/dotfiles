return {
  --disable Neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = true,
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)",      remap = true },
    },
    opts = {
      follow_current_file = true,
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = true,
      },
      window = {
        width = 30,
        mappings = {
          ["<space>"] = "none",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        modified = {
          symbol = "",
          highlight = "NeoTreeModified",
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = "NeoTreeFileName",
        },
        git_status = {
          symbols = {
            -- Change type
            added     = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified  = "M", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted   = "✖", -- this can only be used in the git_status source
            renamed   = "", -- this can only be used in the git_status source
            -- Status type
            untracked = "",
            ignored   = "",
            unstaged  = "U",
            staged    = " ",
            conflict  = "",
          },
        },
      },
    }
  },
}
