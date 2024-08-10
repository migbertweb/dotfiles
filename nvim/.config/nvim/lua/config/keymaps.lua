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
-----------------------------------------------------------------------------------------
-- Next Buffer
map("n", "<TAB>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
-- Lazydocker
map("n", "<leader>ctk", function() Util.float_term({ "lazydocker" }) end, { desc = "LazyDocker" })
-- floating terminal
map("n", "<leader>ft", function() Util.float_term({ cwd = Util.get_root() }, { border = "single" }) end,
  { desc = "Terminal (root dir)" })

