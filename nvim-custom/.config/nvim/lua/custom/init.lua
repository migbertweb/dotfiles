local g = vim.g

-- load your globals, autocmds here or anything .__.
g.luasnippets_path = "/home/migbert/.config/nvim/lua/custom/snippets/"
g.loaded_python3_provider = 1
g.python3_host_prog = "$HOME/proyectos/python/env-django/bin/python"

-- autocmds
--
local api = vim.api
local autocmd = api.nvim_create_autocmd

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
autocmd("BufWritePost", {
	callback = function()
		vim.lsp.buf.format({ async = true })
	end,
})

vim.o.winbar = "%{%v:lua.require'custom.plugins.winbar'.get_winbar()%}"
-- vim.o.winbar = "%{%v:lua.require'custom.statusline.win'.eval()%}"

-- Highlight on yank
local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
	command = "silent! lua vim.highlight.on_yank()",
	group = yankGrp,
})
-- go to last loc when opening a buffer
api.nvim_create_autocmd(
	"BufReadPost",
	{ command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)
-- don't auto comment new line
api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })
-- show cursor line only in active window
local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, { pattern = "*", command = "set cursorline", group = cursorGrp })
api.nvim_create_autocmd(
	{ "InsertEnter", "WinLeave" },
	{ pattern = "*", command = "set nocursorline", group = cursorGrp }
)

api.nvim_create_augroup("LspAttach_inlayhints", {})
api.nvim_create_autocmd("LspAttach", {
	group = "LspAttach_inlayhints",
	callback = function(args)
		if not (args.data and args.data.client_id) then
			return
		end

		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		require("lsp-inlayhints").on_attach(client, bufnr)
	end,
})

-- Config para Omnisharp
-- g.OmniSharp_server_use_mono = 0
-- g.OmniSharp_server_use_net6 = 1
-- g.OmniSharp_selector_ui = "fzf"
--" Use the stdio version of OmniSharp-roslyn - this is the default
-- g.OmniSharp_server_stdio = 1

-- vim.cmd([[
--          augroup blade
--            autocmd!
--            autocmd FileType *.blade.php setlocal html
--          augroup END
--        ]])
