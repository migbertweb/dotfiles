local st_modules = require("nvchad_ui.statusline.modules")
local fn = vim.fn
-- local sep_style = vim.g.statusline_sep_style
-- local separators = (type(sep_style) == "table" and sep_style)
--	or require("nvchad_ui.icons").statusline_separators[sep_style]
-- local sep_l = separators["left"]
-- local sep_r = separators["right"]
return {
	cursor_position = function()
		--		local left_sep = "%#St_pos_sep#" .. sep_l
		local current_line = fn.line(".")
		local total_line = fn.line("$")
		--		local text = math.modf((current_line / total_line) * 100) .. tostring("%%")
		local pos = fn.col(".")
		return st_modules.cursor_position() .. "lin:" .. current_line .. "/" .. total_line .. " col:" .. pos
	end,

	LSP_status = function()
		if rawget(vim, "lsp") then
			for _, client in ipairs(vim.lsp.buf_get_clients()) do
				if client.attached_buffers[vim.api.nvim_get_current_buf()] then
					return (vim.o.columns > 100 and "%#St_LspStatus#" .. "   LSP ~ " .. client.name .. " ")
						or "   LSP "
				end
			end
		end
	end,
}
