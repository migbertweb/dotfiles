-- custom/plugins/configs.lua file
vim.opt.list = true
vim.opt.listchars:append("eol:↴")
local M = {}

M.telescope = {
	extensions_list = { "themes", "terms", "file_browser", "project" },
}

M.mason = {
	ensure_installed = {
		"dockerfile-language-server",
		-- comunes
		"prettierd",
		-- JSON
		"fixjson",
		-- lua stuff
		"lua-language-server",
		"stylua",
		-- C#
		-- "omnisharp",
		-- web dev
		"intelephense",
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"deno",
		"emmet-ls",
		"json-lsp",
		"eslint-lsp",
		-- shell
		-- "shfmt",
		-- "shellcheck",
		-- Python
		"pyright",
		"autopep8",
		"pylint",
		-- C
		--		"clangd",
		--YAML
		"yamllint",
		"yaml-language-server",
		-- PHP
		"phpcs",
		"php-cs-fixer",
	},
}
M.nvchad_ui = {
	statusline = {
		separator_style = "arrow", -- default/round/block/arrow
		overriden_modules = function()
			return require("custom.plugins.ui")
		end,
	},
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
		-- "c_sharp",
		"yaml",
		"dockerfile",
		"tsx",
	},
}
-- explorador de archivos
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
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					default = "",
					empty = "",
					empty_open = "",
					open = "",
					symlink = "",
					symlink_open = "",
					arrow_open = "",
					arrow_closed = "",
				},
				git = {
					unstaged = "",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
}
M.gitsigns = {
	signs = {
		add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
		change = { hl = "DiffChange", text = "", numhl = "GitSignsChangeNr" },
		delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
		topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
		changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
	},
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
	},
	current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
}

return M
