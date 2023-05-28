return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      table.insert(opts.sources, nls.builtins.formatting.deno_fmt)
      table.insert(opts.sources, nls.builtins.formatting.prettier.with({ filetypes = { "html", "markdown", "css" } }))
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "deno")
            table.insert(opts.ensure_installed, "prettier")
    end,
  },

}
