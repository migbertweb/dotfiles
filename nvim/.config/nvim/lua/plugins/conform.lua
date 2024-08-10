return {
{
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
},
{
  "nvimtools/none-ls.nvim",
  optional = true,
  opts = function(_, opts)
    local nls = require("null-ls")
    opts.sources = opts.sources or {}
    table.insert(opts.sources, nls.builtins.formatting.blade_formatter)
  end,
},
}