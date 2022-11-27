local M = {}

local Terminal = require("toggleterm.terminal").Terminal

-- Lazygit on Terminal
local git_tui = "lazygit"
local git_cz = "git cz"
local git_client = Terminal:new({
	cmd = git_tui,
	hidden = true,
	direction = "float",
	float_opts = {
		border = "double",
	},
})
local git_commit = Terminal:new({
	cmd = git_cz,
	--	dir = "git_dir",
	hidden = true,
	direction = "float",
	float_opts = {
		border = "double",
	},
})
-- Manejo de Docker en Lazydocker
local docker_tui = "lazydocker"
local docker_client = Terminal:new({
	cmd = docker_tui,
	dir = "git_dir",
	hidden = true,
	direction = "float",
	float_opts = {
		border = "double",
	},
})
-- Lazydocker
function M.docker_client_toggle()
	docker_client:toggle()
end
-- Lazygit
function M.git_client_toggle()
	git_client:toggle()
end
function M.git_commit_toggle()
	git_commit:toggle()
end

return M
