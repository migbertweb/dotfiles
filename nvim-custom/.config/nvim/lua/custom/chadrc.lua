local M = {}
local pluginConfs = require("custom.plugins.configs")

M.plugins = {
	override = {
		["lukas-reineke/indent-blankline.nvim"] = pluginConfs.blankline,
		["nvim-treesitter/nvim-treesitter"] = pluginConfs.treesitter,
		["kyazdani42/nvim-tree.lua"] = pluginConfs.nvimtree,
		["NvChad/ui"] = pluginConfs.nvchad_ui,
	},
	user = require("custom.plugins"),
	options = {
		lspconfig = {
			setup_lspconf = "custom.plugins.lspconfig",
		},
	},
}
M.ui = {
	transparency = true,
	theme = "tokyonight",
}

M.mappings = require("custom.mappings")

M.options = {
	user = function()
		require("custom.mioptions")
	end,
}

return M
