-- custom.mappings

local M = {}

M.rest = {
	n = {
		["<leader>r"] = { "Rest-API" },
		["<leader>rx"] = { "<Plug>RestNvim", " Consultar API-rest" },
		["<leader>rl"] = { "<Plug>RestNvimLast", "勒Ultimo API-Rest" },
	},
}
M.lazygit = {
	n = {
		["<leader>gu"] = { "<cmd>lua require('custom.utils.term').git_client_toggle()<CR>", "Git UI" },
		["<leader>gc"] = { "<cmd>lua require('custom.utils.term').git_commit_toggle()<CR>", "Conventional Commits" },
	},
}
M.lazydocker = {
	n = {
		["<leader>lk"] = { "<cmd>lua require('custom.utils.term').docker_client_toggle()<CR>", "Docker UI" },
	},
}
M.database = {
	n = {
		["<leader>d"] = { "Database" },
		["<leader>du"] = { "<Cmd>DBUIToggle<Cr>", "Mostrar DB-UI" },
		["<leader>df"] = { "<Cmd>DBUIFindBuffer<Cr>", "Find buffer" },
		["<leader>dr"] = { "<Cmd>DBUIRenameBuffer<Cr>", "Rename buffer" },
		["<leader>dq"] = { "<Cmd>DBUILastQueryInfo<Cr>", "Ultima DB-query" },
	},
}
M.code = {
	n = {
		["<leader>c"] = { "Code Doc" },
		["<leader>cg"] = { "<cmd>Neogen func<CR>", "Func Doc" },
		["<leader>cG"] = { "<cmd>Neogen class<CR>", "Class Doc" },
		["<leader>cd"] = { "<cmd>DogeGenerate<CR>", "Generate Doc" },
	},
}
M.telescope = {
	plugin = true,

	n = {
		["<leader>f"] = { "Telescope" },
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
		["<leader>fz"] = {
			"<cmd> :lua require('telescope').extensions.media_files.media_files()<CR>",
			"冷Media Files",
		},
	},
}
M.lspconfig = {
	plugin = true,
	n = {
		["<leader>f"] = { "Telescope" },
	},
}
M.rnvimr = {
	n = {
		["<C-,>"] = { "<cmd> :RnvimrToggle <cr>", "Ranger" },
	},
}
M.codex = {
	n = {
		["<leader>gz"] = { "<Cmd>lua require('custom.utils.codex').complete()<CR>", "Codex OpenAI" },
	},
}
return M
