local M = {}
local pluginConfs = require("custom.plugins.configs")

M.plugins = {
	override = {
		["williamboman/mason.nvim"] = pluginConfs.mason,
		["lukas-reineke/indent-blankline.nvim"] = pluginConfs.blankline,
		["nvim-treesitter/nvim-treesitter"] = pluginConfs.treesitter,
		["kyazdani42/nvim-tree.lua"] = pluginConfs.nvimtree,
		["NvChad/ui"] = pluginConfs.nvchad_ui,
		["lewis6991/gitsigns.nvim"] = pluginConfs.gitsigns,
	},
	user = require("custom.plugins"),
	options = {},
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
