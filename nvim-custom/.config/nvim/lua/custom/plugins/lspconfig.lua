-- custom.plugins.lspconfig
local utils = require("core.utils")
-- local ih = require("inlay-hints")

-- local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local on_attach = function(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false

	if client.server_capabilities.documentSymbolProvider then
		local navic = require("nvim-navic")
		navic.attach(client, bufnr)
	end

	utils.load_mappings("lspconfig", { buffer = bufnr })

	if client.server_capabilities.signatureHelpProvider then
		require("nvchad_ui.signature").setup(client)
	end
	-- ih.on_attach(client, bufnr)
end

local lspconfig = require("lspconfig")
local servers = {
	"emmet_ls",
	"sumneko_lua",
	"eslint",
	"cssls",
	"intelephense",
	"pyright",
	"jsonls",
	"html",
	"sqlls",
	-- "clangd",
	"yamlls",
	"dockerls",
}
-- LSP settings (for overriding per client)
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help),
}

-- Do not forget to use the on_attach function
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		handlers = handlers,
		settings = {
			Lua = {
				hint = {
					enable = true,
				},
			},
			intelephense = {
				hint = {
					enable = true,
				},
			},
		},
		init_options = {
			onlyAnalyzeProjectsWithOpenFiles = true,
			suggestFromUnimportedLibraries = false,
			closingLabels = true,
		},
	})
end

local util = require("lspconfig/util")
---
lspconfig.emmet_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	handlers = handlers,
	filetypes = {
		"html",
		"blade",
		"typescriptreact",
		"typescript",
		"javascriptreact",
		"javascript",
		"css",
		"sass",
		"scss",
		"less",
	},
})

------
lspconfig.html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	handlers = handlers,
	filetypes = {
		"html",
		"blade",
		"typescriptreact",
		"typescript",
		"javascriptreact",
		"javascript",
		"jsx",
	},
})
--
lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	handlers = handlers,
	setting = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true,
			},
		},
	},
	root_dir = function(fname)
		return util.root_pattern("manage.py", ".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(
			fname
		) or util.path.dirname(fname)
	end,
})
-- lspconfig.omnisharp.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	cmd = { "dotnet", "/home/migbert/.local/share/nvim/mason/packages/omnisharp/OmniSharp.dll" },
--
-- 	-- Enables support for reading code style, naming convention and analyzer
-- 	-- settings from .editorconfig.
-- 	enable_editorconfig_support = true,
--
-- 	-- If true, MSBuild project system will only load projects for files that
-- 	-- were opened in the editor. This setting is useful for big C# codebases
-- 	-- and allows for faster initialization of code navigation features only
-- 	-- for projects that are relevant to code that is being edited. With this
-- 	-- setting enabled OmniSharp may load fewer projects and may thus display
-- 	-- incomplete reference lists for symbols.
-- 	enable_ms_build_load_projects_on_demand = false,
--
-- 	-- Enables support for roslyn analyzers, code fixes and rulesets.
-- 	enable_roslyn_analyzers = false,
--
-- 	-- Specifies whether 'using' directives should be grouped and sorted during
-- 	-- document formatting.
-- 	organize_imports_on_format = true,
--
-- 	-- Enables support for showing unimported types and unimported extension
-- 	-- methods in completion lists. When committed, the appropriate using
-- 	-- directive will be added at the top of the current file. This option can
-- 	-- have a negative impact on initial completion responsiveness,
-- 	-- particularly for the first few completion sessions after opening a
-- 	-- solution.
-- 	enable_import_completion = true,
--
-- 	-- Specifies whether to include preview versions of the .NET SDK when
-- 	-- determining which version to use for project loading.
-- 	sdk_include_prereleases = true,
--
-- 	-- Only run analyzers against open files when 'enableRoslynAnalyzers' is
-- 	-- true
-- 	analyze_open_documents_only = false,
-- })
