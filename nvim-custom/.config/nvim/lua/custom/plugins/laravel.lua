local M = {}

M.setup = function()
	require("laravel").setup({
		split_cmd = "vertical",
		split_width = 120,
		bind_telescope = true,
		ask_for_args = true,
	})
end

return M
