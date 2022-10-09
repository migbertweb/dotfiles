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
  plugin = true,

  n = {
 		["<leader>f"] = { "+Telescope" },
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "find files" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "find oldfiles" },
    ["<leader>fk"] = { "<cmd> Telescope keymaps <CR>", "show keys" },
    -- 
		["<leader>fn"] = { "<cmd> :Telescope file_browser<CR>", " File Browser" },
		["<leader>fp"] = {
			"<cmd> :lua require'telescope'.extensions.project.project{ display_type = 'full'}<CR>",
			"冷Projects",
		},
  },
}


return M
