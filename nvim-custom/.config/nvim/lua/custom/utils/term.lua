local M = {}

local Terminal = require("toggleterm.terminal").Terminal

local git_tui = "lazygit"
-- local git_tui = "gitui"

local git_client = Terminal:new {
  cmd = git_tui,
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
-- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
}

function M.git_client_toggle()
  git_client:toggle()
end

return M
