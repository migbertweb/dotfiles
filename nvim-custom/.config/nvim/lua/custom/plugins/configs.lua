-- custom/plugins/configs.lua file
vim.opt.list = true
vim.opt.listchars:append("eol:↴")
local M = {}

M.nvchad_ui = {
	statusline = {
		separator_style = "arrow", -- default/round/block/arrow
	},

	-- lazyload it when there are 1+ buffers
	--    tabufline = {
	--          enabled = true,
	--                lazyload = true,
	--                      overriden_modules = nil,
	--                         },
}
M.blankline = {
	show_trailing_blankline_indent = true,
	show_first_indent_level = true,
	show_end_of_line = true,
}
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
