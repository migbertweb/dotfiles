-- custom.mappings

local M = {}

M.rest = {
	n = {
		["<leader>rx"] = { "<Plug>RestNvim", "  Consultar API-rest" },
		["<leader>rl"] = { "<Plug>RestNvimLast", "勒  Ultimo API-Rest" },
	},
}

return M
