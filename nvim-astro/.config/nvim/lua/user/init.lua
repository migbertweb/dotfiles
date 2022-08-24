local config = {

	-- Configure AstroNvim updates
	updater = {
		remote = "origin", -- remote to use
		channel = "nightly", -- "stable" or "nightly"
		version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
		branch = "main", -- branch name (NIGHTLY ONLY)
		commit = nil, -- commit hash (NIGHTLY ONLY)
		pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
		skip_prompts = false, -- skip prompts about breaking changes
		show_changelog = true, -- show the changelog after performing an update
		-- remotes = { -- easily add new remotes to track
		--   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
		--   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
		--   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
		-- },
	},

	-- Set colorscheme
	colorscheme = "sonokai",

	-- Override highlight groups in any theme
	highlights = {
		-- duskfox = { -- a table of overrides
		--   Normal = { bg = "#000000" },
		-- },
		default_theme = function(highlights) -- or a function that returns one
			local C = require("default_theme.colors")

			highlights.Normal = { fg = C.fg, bg = C.bg }
			return highlights
		end,
	},

	-- set vim options here (vim.<first_key>.<second_key> =  value)
	options = {
		opt = {
			relativenumber = true, -- sets vim.opt.relativenumber
		},
		g = {
			mapleader = " ", -- sets vim.g.mapleader
			-- Monokai theme
			sonokai_style = "andromeda",
			sonokai_better_performance = 1,
			sonokai_enable_italic = 1,
			sonokai_diagnostic_text_highlight = 1,
			sonokai_diagnostic_line_highlight = 1,
		},
	},

	-- Default theme configuration
	default_theme = {
		diagnostics_style = { italic = true },
		-- Modify the color table
		colors = function(C)
			C.telescope_green = C.green
			C.telescope_red = C.red
			C.telescope_fg = C.fg
			C.telescope_bg = C.black_1
			C.telescope_bg_alt = C.bg_1
			return C
		end,
		highlights = function(hl)
			local C = require("default_theme.colors")
			hl.TelescopeBorder = { fg = C.telescope_bg_alt, bg = C.telescope_bg }
			hl.TelescopeNormal = { bg = C.telescope_bg }
			hl.TelescopePreviewBorder = { fg = C.telescope_bg, bg = C.telescope_bg }
			hl.TelescopePreviewNormal = { bg = C.telescope_bg }
			hl.TelescopePreviewTitle = { fg = C.telescope_bg, bg = C.telescope_green }
			hl.TelescopePromptBorder = { fg = C.telescope_bg_alt, bg = C.telescope_bg_alt }
			hl.TelescopePromptNormal = { fg = C.telescope_fg, bg = C.telescope_bg_alt }
			hl.TelescopePromptPrefix = { fg = C.telescope_red, bg = C.telescope_bg_alt }
			hl.TelescopePromptTitle = { fg = C.telescope_bg, bg = C.telescope_red }
			hl.TelescopeResultsBorder = { fg = C.telescope_bg, bg = C.telescope_bg }
			hl.TelescopeResultsNormal = { bg = C.telescope_bg }
			hl.TelescopeResultsTitle = { fg = C.telescope_bg, bg = C.telescope_bg }
			return hl
		end,

		plugins = { -- enable or disable extra plugin highlighting
			aerial = true,
			beacon = false,
			bufferline = true,
			dashboard = true,
			highlighturl = true,
			hop = false,
			indent_blankline = true,
			lightspeed = false,
			["neo-tree"] = true,
			notify = true,
			["nvim-tree"] = false,
			["nvim-web-devicons"] = true,
			rainbow = true,
			symbols_outline = false,
			telescope = true,
			vimwiki = false,
			["which-key"] = true,
		},
	},

	-- Disable AstroNvim ui features
	ui = {
		nui_input = true,
		telescope_select = true,
	},

	-- Configure plugins
	plugins = {
		-- Add plugins, the packer syntax without the "use"
		init = {

			{ "sainnhe/sonokai" },
			-- You can disable default plugins as follows:
			-- ["goolord/alpha-nvim"] = { disable = true },

			-- You can also add new plugins here as well:
			-- { "andweeb/presence.nvim" },
			-- {
			--   "ray-x/lsp_signature.nvim",
			--   event = "BufRead",
			--   config = function()
			--     require("lsp_signature").setup()
			--   end,
			-- },
		},
		-- All other entries override the setup() call for default plugins
		["null-ls"] = function(config)
			local null_ls = require("null-ls")
			local b = null_ls.builtins
			-- Check supported formatters and linters
			-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
			-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
			config.sources = {
				-- Set a formatter
				-- Set a linter
				b.formatting.prettierd.with({
					filetypes = {
						"vue",
						"css",
						"scss",
						"less",
						"html",
						"json",
						"jsonc",
						"yaml",
						"markdown",
						"graphql",
						"handlebars",
					},
				}),
				b.formatting.deno_fmt,

				-- Lua
				b.formatting.stylua,
				b.diagnostics.luacheck.with({ extra_args = { "--global vim" } }),

				-- Shell
				b.formatting.shfmt,
				b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),

				--Python
				b.formatting.autopep8, --pip install autopep8
				--	b.formatting.black, --pip install black
				b.diagnostics.pylint, --pip install pylint

				-- HTML Django Jinja template
				b.formatting.djlint, -- pip install djlint
				b.diagnostics.djlint, -- pip install djlint

				--JSON
				b.formatting.fixjson, -- npm install -g fixjson
				b.diagnostics.jsonlint, -- npm install -g jsonlint

				-- PHP Formatting & Linter
				b.formatting.phpcsfixer.with({
					extra_args = { "--rules=@PSR12" },
				}), --composer global require friendsofphp/php-cs-fixer
				-- b.formatting.phpcbf, --composer global require friendsofphp/php-cs-fixer
				b.diagnostics.phpcs.with({
					extra_args = { "--standard=PSR12" },
				}), --composer global require "squizlabs/php_codesniffer=*"
			}
			-- set up null-ls's on_attach function
			config.on_attach = function(client)
				-- NOTE: You can remove this on attach function to disable format on save
				if client.resolved_capabilities.document_formatting then
					vim.api.nvim_create_autocmd("BufWritePre", {
						desc = "Auto format before save",
						pattern = "<buffer>",
						callback = vim.lsp.buf.formatting_sync,
					})
				end
			end
			return config -- return final config table
		end,
		treesitter = {
			ensure_installed = { "lua", "php", "http", "html", "bash", "json", "python", "javascript", "typescript" },
		},
		["nvim-lsp-installer"] = {
			ensure_installed = { "sumneko_lua", "pyright", "intelephense", "emmet_ls", "eslint", "jsonls" },
		},
		packer = {
			compile_path = vim.fn.stdpath("data") .. "/packer_compiled.lua",
		},
	},

	-- LuaSnip Options
	luasnip = {
		-- Add paths for including more VS Code style snippets in luasnip
		vscode_snippet_paths = {},
		-- Extend filetypes
		filetype_extend = {
			javascript = { "javascriptreact" },
		},
	},

	-- Modify which-key registration
	["which-key"] = {
		-- Add bindings
		register_mappings = {
			-- first key is the mode, n == normal mode
			n = {
				-- second key is the prefix, <leader> prefixes
				["<leader>"] = {
					-- which-key registration table for normal mode, leader prefix
					-- ["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
				},
			},
		},
	},

	-- CMP Source Priorities
	-- modify here the priorities of default cmp sources
	-- higher value == higher priority
	-- The value can also be set to a boolean for disabling default sources:
	-- false == disabled
	-- true == 1000
	cmp = {
		source_priority = {
			nvim_lsp = 1000,
			luasnip = 750,
			buffer = 500,
			path = 250,
		},
	},

	-- Extend LSP configuration
	lsp = {
		-- enable servers that you already have installed without lsp-installer
		servers = {
			"pyright",
		},
		-- easily add or disable built in mappings added during LSP attaching
		mappings = {
			n = {
				-- ["<leader>lf"] = false -- disable formatting keymap
			},
		},
		-- add to the server on_attach function
		-- on_attach = function(client, bufnr)
		-- end,

		-- override the lsp installer server-registration function
		-- server_registration = function(server, opts)
		--   require("lspconfig")[server].setup(opts)
		-- end,

		-- Add overrides for LSP server settings, the keys are the name of the server
		["server-settings"] = {
			-- example for addings schemas to yamlls
			-- yamlls = {
			--   settings = {
			--     yaml = {
			--       schemas = {
			--         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
			--         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
			--         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
			--       },
			--     },
			--   },
			-- },
		},
	},

	-- Diagnostics configuration (for vim.diagnostics.config({}))
	diagnostics = {
		virtual_text = true,
		underline = true,
	},

	mappings = {
		-- first key is the mode
		n = {
			-- second key is the lefthand side of the map
			["<C-s>"] = { ":w!<cr>", desc = "Save File" },
		},
		t = {
			-- setting a mapping to false will disable it
			-- ["<esc>"] = false,
		},
	},

	-- This function is run last
	-- good place to configuring augroups/autocommands and custom filetypes
	polish = function()
		-- Set key binding
		-- Set autocommands
		vim.api.nvim_create_augroup("packer_conf", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePost", {
			desc = "Sync packer after modifying plugins.lua",
			group = "packer_conf",
			pattern = "plugins.lua",
			command = "source <afile> | PackerSync",
		})

		-- Set up custom filetypes
		-- vim.filetype.add {
		--   extension = {
		--     foo = "fooscript",
		--   },
		--   filename = {
		--     ["Foofile"] = "fooscript",
		--   },
		--   pattern = {
		--     ["~/%.config/foo/.*"] = "fooscript",
		--   },
		-- }
	end,
}

return config
