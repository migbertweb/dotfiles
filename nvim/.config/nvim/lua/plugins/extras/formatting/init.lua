return {
  -- {
  --   "nvimtools/none-ls.nvim",
  --   opts = function(_, opts)
  --     local nls = require("null-ls")
  --     table.insert(
  --       opts.sources,
  --       nls.builtins.formatting.deno_fmt.with({ extra_args = { "--single-quote", "--no-semicolons" } })
  --     )
  --   end,
  -- },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "blade-formatter")
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["javascript"] = { "deno_fmt" },
        ["javascriptreact"] = { "deno_fmt" },
        ["typescript"] = { "deno_fmt" },
        ["typescriptreact"] = { "deno_fmt" },
        ["vue"] = { "prettier" },
        ["css"] = { "prettier" },
        ["scss"] = { "prettier" },
        ["less"] = { "prettier" },
        ["html"] = { "prettier" },
        ["json"] = { "prettier" },
        ["jsonc"] = { "prettier" },
        ["yaml"] = { "prettier" },
        ["markdown"] = { "deno_fmt" },
        ["markdown.mdx"] = { "deno_fmt" },
        ["graphql"] = { "prettier" },
        ["handlebars"] = { "prettier" },
      },
    },
  },
}
