return {
--- blade -----------------------------
  {
    "jwalton512/vim-blade",
  },
--- sql -----------------------------
{
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  opts = { ensure_installed = { "sql" } },
},
{
  "mfussenegger/nvim-lint",
  optional = false,
  opts = {
    linters_by_ft = {
      sql = { "sqlfluff" },
    },
  },
},

{
  "nvim-neo-tree/neo-tree.nvim",
  optional = true,
  opts = function(_, opts)
    opts.open_files_do_not_replace_types = opts.open_files_do_not_replace_types
      or { "terminal", "Trouble", "qf", "Outline", "trouble" }
    table.insert(opts.open_files_do_not_replace_types, "edgy")
  end,
},
}
