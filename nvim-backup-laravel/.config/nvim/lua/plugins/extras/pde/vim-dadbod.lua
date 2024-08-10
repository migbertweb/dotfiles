return {
    {
        "tpope/vim-dadbod",
        lazy = true,
        dependencies = {
            "kristijanhusak/vim-dadbod-ui",
            "tpope/vim-dotenv",
        },
        cmd = { "DBUIToggle", "DBUI", "DBUIAddConnection", "DBUIFindBuffer", "DBUIRenameBuffer", "DBUILastQueryInfo" },
        keys = {
            { "<leader>cdu", "<cmd>DBUIToggle<cr>",        desc = "DB-UI" },
            { "<leader>cdf", "<cmd>DBUIFindBuffer<cr>",    desc = "DB-UI - Find" },
            { "<leader>cdr", "<cmd>DBUIRenameBuffer<cr>",  desc = "DB-UI- Rename" },
            { "<leader>cdq", "<cmd>DBUILastQueryInfo<cr>", desc = "DB-UI- Query" },
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = { "kristijanhusak/vim-dadbod-completion" },
        opts = function(_, opts)
          local cmp = require("cmp")
          opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "vim-dadbod-completion" } }))
        end,
    },
}
