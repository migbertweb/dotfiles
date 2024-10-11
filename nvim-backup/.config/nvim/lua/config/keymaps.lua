-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- This file is automatically loaded by lazyvim.plugins.config

local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("n", "<TAB>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<leader>ctk", function() Util.float_term({ "lazydocker" }) end, { desc = "LazyDocker" })
--map("n", "<leader>tt", function() Util.float_term({ "tokei" }, { cwd = Util.get_root() }) end, { desc = "Tokei" })
map("n", "<leader>ctn", function() Util.float_term({ "navi" }) end, { desc = "Navi" })
-- floating terminal
map("n", "<leader>ft", function() Util.float_term({ cwd = Util.get_root() }, { border = "single" }) end,
  { desc = "Terminal (root dir)" })

