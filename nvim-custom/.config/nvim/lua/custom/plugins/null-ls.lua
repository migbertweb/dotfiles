local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {

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
	-- deno
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

	-- YAML
	b.diagnostics.yamllint,

	-- PHP Formatting & Linter
	b.formatting.phpcsfixer.with({
		extra_args = { "--rules=@PSR12" },
	}), --composer global require friendsofphp/php-cs-fixer
	-- b.formatting.phpcbf, --composer global require friendsofphp/php-cs-fixer
	b.diagnostics.phpcs.with({
		extra_args = { "--standard=PSR12" },
	}), --composer global require "squizlabs/php_codesniffer=*"
}

local M = {}

M.setup = function()
	null_ls.setup({
		debug = true,
		sources = sources,

		-- format on save
		on_attach = function(client)
			if client.resolved_capabilities.document_formatting then
				vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
			end
		end,
	})
end

return M
