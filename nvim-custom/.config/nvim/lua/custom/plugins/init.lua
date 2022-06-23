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
	-- load it after nvim-lspconfig cuz we lazy loaded lspconfig
	-- -- Github Copilot
	-- ["github/copilot.vim"] = {
	-- 	after = "nvim-lspconfig",
	-- },
}
