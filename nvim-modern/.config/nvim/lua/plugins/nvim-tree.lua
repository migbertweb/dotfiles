return {
  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "<C-n>", "<cmd>:NvimTreeToggle<cr>", desc = "Nvim-Tree" },
      { "<C-e>", "<cmd>:NvimTreeFocus<cr>", desc = "Nvim-Tree" },
    },
    config = function()
      require("nvim-tree").setup {
        sort_by = "case_sensitive",
        git = {
          enable = true,
        },
        view = {
          adaptive_size = false,
          hide_root_folder = false,
          --		width = 25,
          mappings = {
            list = {
              { key = "u", action = "dir_up" },
            },
          },
        },
        filters = {
          dotfiles = true,
        },
        renderer = {
          highlight_git = true,
          icons = {
            show = {
              git = true,
            },
            glyphs = {
              default = "",
              symlink = "",
              folder = {
                default = "",
                empty = "",
                empty_open = "",
                open = "",
                symlink = "",
                symlink_open = "",
                arrow_open = "",
                arrow_closed = "",
              },
              git = {
                unstaged = "",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
      }
    end,
  },
}
