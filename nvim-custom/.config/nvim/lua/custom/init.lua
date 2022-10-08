-- example file i.e lua/custom/init.lua
local g = vim.g

-- load your globals, autocmds here or anything .__.
--require("core.utils").load_mappings()
g.luasnippets_path = "custom.snippets"

-- Config para Omnisharp
-- g.OmniSharp_server_use_mono = 0
-- g.OmniSharp_server_use_net6 = 1
-- g.OmniSharp_selector_ui = "fzf"
--" Use the stdio version of OmniSharp-roslyn - this is the default
-- g.OmniSharp_server_stdio = 1
