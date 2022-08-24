local st_modules = require("nvchad_ui.statusline.modules")
local fn = vim.fn
local sep_style = vim.g.statusline_sep_style
local separators = (type(sep_style) == "table" and sep_style)
	or require("nvchad_ui.icons").statusline_separators[sep_style]
local sep_l = separators["left"]
local sep_r = separators["right"]

return {
	cursor_position = function()
		local left_sep = "%#St_pos_sep#" .. sep_l .. "%#St_pos_icon#" .. " "
		local current_line = fn.line(".")
		--		local total_line = fn.line("$")
		local pos = fn.col(".")
		--		return st_modules.cursor_position() .. " lin: " .. current_line .. " col " .. pos
		return left_sep .. "%#St_pos_text#" .. " " .. " lin: " .. current_line .. " col " .. pos
	end,
}
