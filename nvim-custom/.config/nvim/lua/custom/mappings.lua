-- custom.mappings

local M = {}

M.rest = {
	n = {
		["<leader>r"] = { "Rest-API" },
		["<leader>rx"] = { "<Plug>RestNvim", " Consultar API-rest" },
		["<leader>rl"] = { "<Plug>RestNvimLast", "勒Ultimo API-Rest" },
	},
}
M.telescope = {
	n = {
		["<leader>t"] = { "Telescope" },
		["<leader>tn"] = { "<cmd> :Telescope file_browser<CR>", " File Browser" },
		["<leader>tp"] = {
			"<cmd> :lua require'telescope'.extensions.project.project{ display_type = 'full'}<CR>",
			"冷Projects",
		},
	},
}
return M
