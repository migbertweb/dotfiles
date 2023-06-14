return {
  "akinsho/bufferline.nvim",
  enabled = true,
  opts = {
    options = {
      --numbers = "buffer_id", --
      diagnostics = false,
      always_show_bufferline = true,
      hover = {
               enabled = true,
               delay = 200,
               reveal = {'close'}
           },
           buffer_close_icon = "",
      
      indicator = {
        icon = "▎", -- this should be omitted if indicator style is not 'icon'
        style = "underline", --'icon' | 'underline' | 'none',
      },
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          highlight = "Directory",
          separator = true,
          text_align = "left",
        },
      },
       left_trunc_marker = "",
      separator_style = "thick", -- "slant", --| "thick" | "thin" | { 'any', 'any' },
      custom_areas = {
        right = function()
            local result = {}
            local seve = vim.diagnostic.severity
            local error = #vim.diagnostic.get(0, {severity = seve.ERROR})
            local warning = #vim.diagnostic.get(0, {severity = seve.WARN})
            local info = #vim.diagnostic.get(0, {severity = seve.INFO})
            local hint = #vim.diagnostic.get(0, {severity = seve.HINT})
    
            if error ~= 0 then
                table.insert(result, {text = "  " .. error, fg = "#EC5241"})
            end
    
            if warning ~= 0 then
                table.insert(result, {text = "  " .. warning, fg = "#EFB839"})
            end
    
            if hint ~= 0 then
                table.insert(result, {text = "  " .. hint, fg = "#A3BA5E"})
            end
    
            if info ~= 0 then
                table.insert(result, {text = "  " .. info, fg = "#7EA9A7"})
            end
            return result
        end,
        },

    },

    
  
  
  highlights = {
      fill = {
          fg = { attribute = "fg", highlight = "Normal" },
          bg = { attribute = "bg", highlight = "StatusLineNC" },
      },
      background = {
          fg = { attribute = "fg", highlight = "Normal" },
          bg = { attribute = "bg", highlight = "StatusLine" },
      },
      buffer_visible = {
          fg = { attribute = "fg", highlight = "Normal" },
          bg = { attribute = "bg", highlight = "Normal" },
      },
      buffer_selected = {
          fg = { attribute = "fg", highlight = "Normal" },
          bg = { attribute = "bg", highlight = "Normal" },
      },
      separator = {
          fg = { attribute = "bg", highlight = "Normal" },
          bg = { attribute = "bg", highlight = "StatusLine" },
      },
      separator_selected = {
          fg = { attribute = "fg", highlight = "Special" },
          bg = { attribute = "bg", highlight = "Normal" },
      },
      separator_visible = {
          fg = { attribute = "fg", highlight = "Normal" },
          bg = { attribute = "bg", highlight = "StatusLineNC" },
      },
      close_button = {
          fg = { attribute = "fg", highlight = "Normal" },
          bg = { attribute = "bg", highlight = "StatusLine" },
      },
      close_button_selected = {
          fg = { attribute = "fg", highlight = "Normal" },
          bg = { attribute = "bg", highlight = "Normal" },
      },
      close_button_visible = {
          fg = { attribute = "fg", highlight = "Normal" },
          bg = { attribute = "bg", highlight = "Normal" },
      },
  },
  },
}
