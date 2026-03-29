return {
  "stevearc/conform.nvim",
  opts = function()
    ---@class ConformOpts
    local opts = {
      default_format_opts = {
        timeout_ms = 10000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
        lsp_format = "fallback", -- not recommended to change
      },
      ---@type table<string, conform.FormatterUnit[]>
      formatters_by_ft = {
        blade = { "blade-formatter", "rustywind" },
      },
    }
    return opts
  end,
}
