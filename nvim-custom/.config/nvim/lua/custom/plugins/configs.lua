-- custom/plugins/configs.lua file
vim.opt.list = true
vim.opt.listchars:append("eol:↴")

local M = {}

local function button(sc, txt, keybind)
	local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

	local opts = {
		position = "center",
		text = txt,
		shortcut = sc,
		cursor = 5,
		width = 36,
		align_shortcut = "right",
		hl = "AlphaButtons",
	}

	if keybind then
		opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
	end

	return {
		type = "button",
		val = txt,
		on_press = function()
			local key = vim.api.nvim_replace_termcodes(sc_, true, false, true) or ""
			vim.api.nvim_feedkeys(key, "normal", false)
		end,
		opts = opts,
	}
end
M.packer = {
	profile = {
		enable = true,
		threshold = 1, -- the amount in ms that a plugin's load time must be over for it to be included in the profile
	},
}
M.alpha = {
	buttons = {
		type = "group",
		val = {
			button("SPC f f", "  Buscar Archivo  ", ":Telescope find_files<CR>"),
			button("SPC f o", "  Recientes  ", ":Telescope oldfiles<CR>"),
			button("SPC f w", "  Buscar Palabras  ", ":Telescope live_grep<CR>"),
			button(
				"SPC f w",
				"冷 Proyectos  ",
				":lua require'telescope'.extensions.project.project{ display_type = 'full'}<CR>"
			),
			button("SPC b m", "  Marcadores  ", ":Telescope marks<CR>"),
			button("SPC t h", "  Temas  ", ":Telescope themes<CR>"),
			button("SPC e s", "  Configuracion", ":e $MYVIMRC | :cd %:p:h <CR>"),
		},
		opts = {
			spacing = 1,
		},
	},
	headerPaddingTop = { type = "padding", val = 2 },
	headerPaddingBottom = { type = "padding", val = 2 },
}
M.telescope = {
	extensions_list = { "media_files", "themes", "terms", "file_browser", "project", "notify", "laravel" },
}
M.cmp = {
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "cmp_tabnine" },
		{ name = "nvim_lsp_signature_help" },
	},
	formatting = {
		format = function(_, vim_item)
			local icons = require("nvchad_ui.icons").lspkind
			vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
			-- Source
			vim_item.menu = ({
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[Lua]",
				path = "[path]",
				cmp_tabnine = "[TNine]",
				nvim_lsp_signature_help = "[Signature]",
			})[_.source.name]
			return vim_item
		end,
	},
}
M.mason = {
	ensure_installed = {
		"dockerfile-language-server",
		-- comunes
		"prettierd",
		"prettier",
		-- JSON
		"fixjson",
		-- lua stuff
		"lua-language-server",
		"stylua",
		-- C#
		-- "omnisharp",
		-- web dev
		"djlint",
		"intelephense",
		"css-lsp",
		"blade-formatter",
		"html-lsp",
		"typescript-language-server",
		"deno",
		"emmet-ls",
		"json-lsp",
		"eslint-lsp",
		"tailwindcss-language-server",
		-- shell
		-- "shfmt",
		-- "shellcheck",
		-- Python
		"pyright",
		-- "autopep8",
		-- "pylint",
		"flake8",
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
	autotag = {
		enable = true,
		filetypes = {
			"html",
			"blade",
			"xml",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
			"vue",
			"tsx",
			"jsx",
			"rescript",
			"xml",
			"php",
			"markdown",
			"glimmer",
			"handlebars",
			"hbs",
		},
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
		-- colors = {
		-- 	-- Colors here table of hex strings
		-- },
	},
}
-- explorador de archivos
M.nvimtree = {
	sort_by = "case_sensitive",
	git = {
		enable = true,
	},
	view = {
		adaptive_size = false,
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
