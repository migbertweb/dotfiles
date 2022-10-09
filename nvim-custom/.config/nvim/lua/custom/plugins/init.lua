-- custom/plugins/init.lua
local overrides = require("custom.plugins.configs")
return {
	-----------------------------------------------------------------------------
	-- overrides options
	-- --------------------------------------------------------------------------
	["williamboman/mason.nvim"] = { override_options = overrides.mason },
	["lukas-reineke/indent-blankline.nvim"] = { override_options = overrides.blankline },

	["nvim-treesitter/nvim-treesitter"] = {
		override_options = overrides.treesitter,
		rainbow = {
			enable = true,
			extended_mode = true,
			max_file_lines = nil,
			-- colors = {}, -- table of hex strings
		},
	},

	["kyazdani42/nvim-tree.lua"] = { override_options = overrides.nvimtree },
	["NvChad/ui"] = { override_options = overrides.nvchad_ui },
	["lewis6991/gitsigns.nvim"] = { override_options = overrides.gitsigns },
	["nvim-telescope/telescope.nvim"] = { override_options = overrides.telescope },
	-------------------------------------------------------------------------------
	-- Install new Plugins
	-- ----------------------------------------------------------------------------
	-- nvim-lspconfig
	["neovim/nvim-lspconfig"] = {
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.plugins.lspconfig")
		end,
	},
	-- autoinstall lsp server con williamboman/mason-lspconfig.nvim
	["williamboman/mason-lspconfig.nvim"] = {
		after = {
			"nvim-lspconfig",
			"mason.nvim",
		},
		config = function()
			require("custom.plugins.mason-lspconfig").setup()
		end,
	},
	-- Auto install mason-null-ls
	["jayp0521/mason-null-ls.nvim"] = {
		after = {
			"null-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				automatic_installation = true,
			})
		end,
	},
	-- nvim-Notify - notificaciones en nvim
	["rcarriga/nvim-notify"] = {
		after = "base46",
		config = function()
			require("custom.plugins.nvim-notify").setup()
		end,
	},
	-- OmniSharp/omnisharp-vim para el desarrollo de C#
	-- ["OmniSharp/omnisharp-vim"] = {
	-- 	after = "nvim-lspconfig",
	-- },
	-- Alpha Dashboard
	["goolord/alpha-nvim"] = false,
	-- Formatter
	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("custom.plugins.null-ls").setup()
		end,
	},
	-- "NTBBloodbath/rest.nvim", Cliente API
	["NTBBloodbath/rest.nvim"] = {
		config = function()
			require("custom.plugins.rest").setup()
		end,
	},
	-- folke/which-key muestra una ayuda para los shortcut
	["folke/which-key.nvim"] = {
		disable = false,
	},
	-- tpope/vim-fugitive gestion de Git desde vim
	["tpope/vim-fugitive"] = {
		disable = false,
		after = "base46",
		keys = { "g" },
	},
	-- archivos .Env
	["tpope/vim-dotenv"] = {
		after = "base46",
	},
	-- cambio de tilde o comillas
	["tpope/vim-surround"] = {
		after = "base46",
	},
	-- blade syntax
	["jwalton512/vim-blade"] = {
		setup = function()
			require("core.lazy_load").on_file_open("nvim-treesitter")
		end,
	},
	-- doc archivos js
	["heavenshell/vim-jsdoc"] = {
		after = "base46",
	},
	-- Telescope File Browser
	["nvim-telescope/telescope-file-browser.nvim"] = {},
	-- Telescope Projets
	["nvim-telescope/telescope-project.nvim"] = {},
	-- treesitter Raimbow
	["p00f/nvim-ts-rainbow"] = {},
}
