local M = {}
local pluginConfs = require("custom.plugins.configs")

M.plugins = {
	override = {
		["nvim-treesitter/nvim-treesitter"] = pluginConfs.treesitter,
		["kyazdani42/nvim-tree.lua"] = pluginConfs.nvimtree,
	},
	user = require("custom.plugins"),
	options = {
		lspconfig = {
			setup_lspconf = "custom.plugins.lspconfig",
		},
	},
}
M.ui = {
	statusline = {
		separator_style = "arrow",
	},
	transparency = true,
	theme = "tokyodark",
}

M.mappings = require("custom.mappings")

return M
