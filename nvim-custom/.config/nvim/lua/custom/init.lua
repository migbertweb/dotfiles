-- example file i.e lua/custom/init.lua
local g = vim.g

-- load your globals, autocmds here or anything .__.
--require("core.utils").load_mappings()
-- g.luasnippets_path = "/home/migbert/.config/nvim/lua/custom/snippets/"
g.loaded_python3_provider = 1
-- autocmds
local autocmd = vim.api.nvim_create_autocmd
autocmd("CursorHold", {
	buffer = bufnr,
	callback = function()
		local opts = {
			focusable = false,
			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
			border = "rounded",
			source = "always",
			prefix = " ",
			scope = "cursor",
		}
		vim.diagnostic.open_float(nil, opts)
	end,
})
autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format({ async = true })
	end,
})

-- Config para Omnisharp
-- g.OmniSharp_server_use_mono = 0
-- g.OmniSharp_server_use_net6 = 1
-- g.OmniSharp_selector_ui = "fzf"
--" Use the stdio version of OmniSharp-roslyn - this is the default
-- g.OmniSharp_server_stdio = 1
