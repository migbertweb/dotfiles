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
-----------------------------------------------------------------------------------------
-- Terminal
local Terminal  = require('toggleterm.terminal').Terminal
local lsp_util = require('lspconfig').util

-- Configuración para un terminal específico en el root del proyecto
local project_terminal = Terminal:new({
  dir = lsp_util.root_pattern(".git")(vim.fn.getcwd()) or vim.fn.getcwd(), -- Establece el directorio raíz del proyecto
  direction = "horizontal", -- Puedes cambiar la dirección según prefieras (float, horizontal, vertical)
  -- Otras configuraciones como float_opts, etc.
})

-- Función para abrir el terminal
function _PROJECT_TERM_TOGGLE()
  project_terminal:toggle()
end
-----
map("n", [[<C-\>]], "<cmd>lua _PROJECT_TERM_TOGGLE()<cr>", { desc = "terminal root" })
-----------------------------------------------------------------------------------------
-- Lazydocker
map("n", "<leader>ctk", function()
  LazyVim.terminal("lazydocker")
end, { desc = "LazyDocker" })
-----------------------------------------------------------------------------------------
