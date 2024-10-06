-- local icons = require("config.icons")
return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = true,
  init = function()
    vim.g.neo_tree_remove_legacy_commands = true
  end,
keys = {
   {
     "<C-f>",
     function()
       require("neo-tree.command").execute({ action = "focus", dir = require("lazyvim.util").get_root() })
     end,
     desc = "Explorer NeoTree (root dir)",
   },
 },
  opts = {
    auto_clean_after_session_restore = true,
    close_if_last_window = true,
    event_handlers = {
      {
        event = "file_opened",
        handler = function(file_path)
          vim.cmd("Neotree close")
        end,
      },
      {
        event = "file_added",
        handler = function(file)
          vim.cmd("edit " .. file)
          print(file, " Creado ")
  vim.cmd("Neotree close")
        end,
      },
    },
    window = {
      width = 35,
    },
    filesystem = {
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
    },
  },
}
