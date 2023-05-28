return {
  "nvim-tree/nvim-tree.lua",
  enabled = false,
  version = "*",
  dependencies = {
    "anuvyklack/hydra.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys =
  {
    {
      "<leader>e",
      "<cmd>:NvimTreeToggle<cr>",
      desc = "NvimTree File-Browser"
    },

    {
      "<leader>E",
      "<cmd>:NvimTreeFocus<cr>",
      desc = "NvimTree Focus"
    }
  },
  config = function()
    -- close the tab/nvim when nvim-tree is the last window.
    vim.api.nvim_create_autocmd("BufEnter", {
      nested = true,
      callback = function()
        if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
          vim.cmd "quit"
        end
      end
    })
    -- Automatically open file upon creation
    local api = require("nvim-tree.api")
    api.events.subscribe(api.events.Event.FileCreated, function(file)
      vim.cmd("edit " .. file.fname)
    end)
    --
    -- auto show hydra on nvimtree focus
    local function change_root_to_global_cwd()
      local global_cwd = vim.fn.getcwd()
      -- local global_cwd = vim.fn.getcwd(-1, -1)
      api.tree.change_root(global_cwd)
    end

    local hint = [[
 _n_: New    _c_: Path yank    _/_: Filter
 _y_: Copy   _r_: Rename       _w_: cd CWD
 _p_: Paste  _d_: Remove       _?_: Help
 _x_: Cut    _h_: Hidden
 ^
]]

    -- ^ ^           _q_: exit

    local nvim_tree_hydra = nil
    local nt_au_group = vim.api.nvim_create_augroup("NvimTreeHydraAu", { clear = true })

    local Hydra = require "hydra"
    local function spawn_nvim_tree_hydra()
      nvim_tree_hydra = Hydra {
        name = "NvimTree",
        hint = hint,
        config = {
          color = "pink",
          invoke_on_body = true,
          buffer = 0, -- only for active buffer
          hint = {
            position = "bottom",
            border = "rounded",
          },
        },
        mode = "n",
        body = "H",
        heads = {
          { "w", change_root_to_global_cwd,     { silent = true } },
          { "c", api.fs.copy.absolute_path,     { silent = true } },
          { "/", api.live_filter.start,         { silent = true } },
          { "y", api.fs.copy.node,              { silent = true } },
          { "x", api.fs.cut,                    { exit = true, silent = true } },
          { "p", api.fs.paste,                  { exit = true, silent = true } },
          { "r", api.fs.rename,                 { silent = true } },
          { "d", api.fs.remove,                 { silent = true } },
          { "n", api.fs.create,                 { silent = true } },
          { "h", api.tree.toggle_hidden_filter, { silent = true } },
          { "?", api.tree.toggle_help,          { silent = true } },
          -- { "q", nil, { exit = true, nowait = true } },
        },
      }
      nvim_tree_hydra:activate()
    end

    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      pattern = "*",
      callback = function(opts)
        if vim.bo[opts.buf].filetype == "NvimTree" then
          spawn_nvim_tree_hydra()
        else
          if nvim_tree_hydra then
            nvim_tree_hydra:exit()
          end
        end
      end,
      group = nt_au_group,
    })
    --
    require("nvim-tree").setup({
      sync_root_with_cwd = false,
      prefer_startup_root = true,
      disable_netrw = true,
      hijack_cursor = true,
      hijack_netrw = true,
      view = {
        width = 30,
        signcolumn = "yes",
      },
      filters = {
        custom = { "^.git$" },
        exclude = {},
      },
      update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = {},
      },
      renderer = {
        highlight_git = true,
        highlight_opened_files = "all",
        highlight_modified = "all",
        icons = {
          git_placement = "after",
          modified_placement = "after",
          glyphs = {
            git = {
              unstaged = "U",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
    })
  end
}
