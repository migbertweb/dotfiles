local status_ok, notify = pcall(require, "notify")
if not status_ok then
	return
end

local M = {}

M.setup = function()
	notify.setup({
		background_colour = "#000000",
	})
	vim.notify = notify
end
return M
