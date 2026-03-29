------------------------------------------------------------------
-- LSP Server to use for PHP.
-- Set to "intelephense" to use intelephense instead of phpactor.
-- vim.g.lazyvim_php_lsp = "intelephense"
------------------------------------------------------------------
-- Local Leader
vim.g.maplocalleader = ","
-- Providers
vim.g.python3_host_prog = "/usr/bin/python3"
-- options
-- vim.o.colorcolumn = "79"
vim.o.relativenumber = false
vim.o.mousemoveevent = true
vim.o.updatetime = 200
vim.o.redrawtime = 10000
vim.o.re = 0
------------------------------------------------------------------
vim.g.lazyvim_picker = "fzf"
------------------------------------------------------------------
-- LSP Server to use for Python.
-- Set to "basedpyright" to use basedpyright instead of pyright.
vim.g.lazyvim_python_lsp = "pyright"
-- Set to "ruff_lsp" to use the old LSP implementation version.
vim.g.lazyvim_python_ruff = "ruff"
------------------------------------------------------------------
-- añadiendo opciones para DBui
vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_show_database_icon = 1
vim.g.db_ui_force_echo_notifications = 1
vim.g.db_ui_win_position = "right"
vim.g.db_ui_winwidth = 50
vim.g.db_ui_icons = {
  expanded = {
    db = "▾ ",
    buffers = "▾ ",
    saved_queries = "▾ ",
    schemas = "▾ ",
    schema = "▾ פּ",
    tables = "▾ 藺",
    table = "▾ ",
  },
  collapsed = {
    db = "▸ ",
    buffers = "▸ ",
    saved_queries = "▸ ",
    schemas = "▸ ",
    schema = "▸ פּ",
    tables = "▸ 藺",
    table = "▸ ",
  },
  saved_query = "",
  new_query = "璘",
  tables = "離",
  buffers = "﬘",
  add_connection = "",
  connection_ok = "✓",
  connection_error = "✕",
}
------------------------------------------------------------------
-- vim.g.matchup_matchparen_offscreen = { method = 'popup' }
vim.g.matchup_surround_enabled = 1 -- Habilitar envolvente

-- Configuración para mostrar una línea visual
-- vim.cmd [[
--  highlight MatchParenCur guibg=none gui=underline cterm=underline
--  highlight MatchWord guibg=none gui=underline cterm=underline
-- ]]
