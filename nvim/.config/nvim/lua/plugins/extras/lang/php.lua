return {
-------------- NVIM-DAP --------------
{
  "mfussenegger/nvim-dap",
  optional = true,
  opts = function()
    local dap = require("dap")
    local path = require("mason-registry").get_package("php-debug-adapter"):get_install_path()
    dap.adapters.php = {
      type = "executable",
      command = "node",
      args = { path .. "/extension/out/phpDebug.js" },
    }
  end,
},
------------------------------------------------------
-------------- NONE-LS --------------
--{
--  "nvimtools/none-ls.nvim",
--  optional = true,
--  opts = function(_, opts)
--    local nls = require("null-ls")
--    opts.sources = opts.sources or {}
    -- table.insert(opts.sources, nls.builtins.formatting.phpcsfixer)
    -- table.insert(opts.sources, nls.builtins.diagnostics.phpcs.with({ extra_args = { "--standard=PSR12" } }))
--    table.insert(opts.sources, nls.builtins.formatting.pint)
--  end,
--},
------------------------------------------------------
-------------- MASON --------------
{
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
--      "phpcs",
      "php-cs-fixer",
--      "pint",
    },
  },
},
------------------------------------------------------
-------------- NVIM-LINT --------------
--{
--  "mfussenegger/nvim-lint",
--  optional = true,
--  opts = {
--    linters_by_ft = {
--      php = { "phpcs" },
--    },
--  },
--},
------------------------------------------------------
-------------- CONFORM --------------
{
 "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      php = { "php_cs_fixer" },
    },
  },
},
}
