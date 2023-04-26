-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--------------------------------------------

-- vim.o.colorcolumn = "80"
-- vim.o.wrap = true
-- vim.o.shortmess = "filnxtToOFWIcC"
vim.o.relativenumber = false
--
vim.opt.laststatus = 2
vim.opt.showtabline = 2
vim.opt.termguicolors = true
-- añadiendo opciones para DBui
vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_show_database_icon = 1
vim.g.db_ui_force_echo_notifications = 1
vim.g.db_ui_win_position = 'right'
vim.g.db_ui_winwidth = 50
vim.g.db_ui_icons = {
  expanded = {
    db = '▾ ',
    buffers = '▾ ',
    saved_queries = '▾ ',
    schemas = '▾ ',
    schema = '▾ פּ',
    tables = '▾ 藺',
    table = '▾ ',
  },
  collapsed = {
    db = '▸ ',
    buffers = '▸ ',
    saved_queries = '▸ ',
    schemas = '▸ ',
    schema = '▸ פּ',
    tables = '▸ 藺',
    table = '▸ ',
  },
  saved_query = '',
  new_query = '璘',
  tables = '離',
  buffers = '﬘',
  add_connection = '',
  connection_ok = '✓',
  connection_error = '✕',
}
