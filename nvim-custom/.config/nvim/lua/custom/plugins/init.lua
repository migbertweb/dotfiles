-- custom/plugins/init.lua

return {
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
			"mason.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				automatic_installation = true,
			})
			require("mason-null-ls").check_install(true)
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
	["OmniSharp/omnisharp-vim"] = {
		after = "nvim-lspconfig",
	},
	-- Alpha Dashboard
	["goolord/alpha-nvim"] = {
		disable = false,
	},
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
	-- load it after nvim-lspconfig cuz we lazy loaded lspconfig
	-- -- Github Copilot
	-- ["github/copilot.vim"] = {
	-- 	after = "nvim-lspconfig",
	-- },
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
	["heavenshell/vim-jsdoc"] = {
		after = "base46",
	},
}
