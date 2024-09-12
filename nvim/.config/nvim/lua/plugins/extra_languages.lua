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

}
