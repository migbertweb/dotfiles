-- custom/plugins/init.lua

return {
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
	-- tpope/vim-fugitive gestion de Git desde vim
	["tpope/vim-fugitive"] = {
		after = "base46",
		keys = { "g" },
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
}
