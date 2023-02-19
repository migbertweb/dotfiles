return {
    {
        "akinsho/bufferline.nvim",
        opts = {
            options = {
                --numbers = "buffer_id", --
                diagnostics = "nvim_lsp",
                always_show_bufferline = false,
                diagnostics_indicator = function(_, _, diag)
                  local icons = require("lazyvim.config").icons.diagnostics
                  local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                      .. (diag.warning and icons.Warn .. diag.warning or "")
                  return vim.trim(ret)
                end,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-tree",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
                separator_style = "slant" --| "thick" | "thin" | { 'any', 'any' },
            },
        },
    }
}
