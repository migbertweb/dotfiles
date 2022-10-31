local mason_lspconfig = require("mason-lspconfig")
local M = {}
M.setup = function()
  require("mason").setup()
	mason_lspconfig.setup({
		-- ensure_installed = {
		-- 	"dockerfile-language-server",
		-- 	-- comunes
		-- 	"prettierd",
		-- 	-- JSON
		-- 	"fixjson",
		-- 	-- lua stuff
		-- 	"lua-language-server",
		-- 	"stylua",
		-- 	-- "luacheck",
		-- 	-- C#
		-- 	-- "omnisharp",
		-- 	-- web dev
		-- 	"intelephense",
		-- 	"css-lsp",
		-- 	"html-lsp",
		-- 	"typescript-language-server",
		-- 	"deno",
		-- 	"emmet-ls",
		-- 	"json-lsp",
		-- 	"eslint-lsp",
  --     "sqlls",
		-- 	-- shell
		-- 	-- "shfmt",
		-- 	-- "shellcheck",
		-- 	-- Python
		-- 	"pyright",
		-- 	-- "autopep8",
		-- 	-- "pylint",
		-- 	"flake8",
		-- 	-- C
		-- 	--		"clangd",
		-- 	--YAML
		-- 	"yamllint",
		-- 	"yaml-language-server",
		-- 	-- PHP
		-- 	"phpcs",
		-- 	"php-cs-fixer",
		-- },
		automatic_installation = true,
	})
end
return M
