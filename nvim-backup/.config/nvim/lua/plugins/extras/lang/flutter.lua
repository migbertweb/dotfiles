return {
    {
        'akinsho/flutter-tools.nvim',
        lazy = false,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
        keys = {
            {
                "<leader>m",
                "<cmd>:Telescope flutter commands<cr>",
                desc = " Flutter Commands"
            },
        },
        config = function()
            require("flutter-tools").setup({
                ui = {
                    notification_style = 'plugin'
                },
                decorations = {
                    statusline = {
                        app_version = true,
                        device = true,
                    }
                },
                dev_log = {
                    open_cmd = "edit", -- command to use to open the log buffer
                  },
            })
        end
    },
    -- Instalar treesitter Parser para Dart
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                vim.list_extend(opts.ensure_installed, {
                    "dart",
                })
            end
        end,
    },
}
