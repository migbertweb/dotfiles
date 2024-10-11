return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      table.insert(opts.sources,
        nls.builtins.formatting.deno_fmt.with({ extra_args = { "--single-quote", "--no-semicolons" } }))
      table.insert(opts.sources, nls.builtins.formatting.prettierd.with({ filetypes = { "html", "css" } }))
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "deno")
      table.insert(opts.ensure_installed, "prettierd")
    end,
  },

}
