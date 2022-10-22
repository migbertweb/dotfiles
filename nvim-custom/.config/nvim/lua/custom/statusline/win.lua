local M = {}

vim.api.nvim_set_hl(0, "WinBarPath", { bg = "#dedede", fg = "#363636" })
vim.api.nvim_set_hl(0, "WinBarModified", { bg = "#dedede", fg = "#ff3838" })

function M.eval()
	local function status_line()
		local mode = "%-5{%v:lua.string.upper(v:lua.vim.fn.mode())%}"
		local file_name = "%-.16t"
		local buf_nr = "[%n]"
		local modified = " %-m"
		local file_type = " %y"
		local right_align = "%="
		local line_no = "%10([%l/%L%)]"
		local pct_thru_file = "%5p%%"

		return string.format(
			"%s%s%s%s%s%s%s%s",
			mode,
			file_name,
			buf_nr,
			modified,
			file_type,
			right_align,
			line_no,
			pct_thru_file
		)
	end
	vim.opt.winbar = status_line()
	----
	-- local file_path = vim.api.nvim_eval_statusline('%f', {}).str
	-- local modified = vim.api.nvim_eval_statusline('%M', {}).str == '+' and '⊚' or ''
	--
	-- file_path = file_path:gsub('/', ' ➤ ')
	--
	-- return '%#WinBarPath#'
	--  .. file_path
	--  .. '%*'
	--  .. '%#WinBarModified#'
	--  .. modified
	--  .. '%*'
end

return M
