-- custom/plugins/configs.lua file

local M = {}

M.treesitter = {
	ensure_installed = {
		"lua",
		"html",
		"css",
		"php",
		"json",
		"http",
		"python",
		"bash",
		"javascript",
		"typescript",
	},
}

M.nvimtree = {
	sort_by = "case_sensitive",
	git = {
		enable = true,
	},
	view = {
		adaptive_size = true,
		hide_root_folder = false,
		--		width = 25,
		mappings = {
			list = {
				{ key = "u", action = "dir_up" },
			},
		},
	},
	filters = {
		dotfiles = true,
	},
	renderer = {
		highlight_git = true,
		icons = {
			show = {
				git = true,
			},
		},
	},
}
return M
