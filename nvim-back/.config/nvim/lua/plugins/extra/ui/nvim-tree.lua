return {
    -- install nvim-tree
    {
        "nvim-tree/nvim-tree.lua",
        enabled = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- optional, for file icons
        },
        keys = {
            { "<leader>e", "<cmd>:NvimTreeToggle<cr>", desc = "Explorer Nvim-Tree",       remap = true },
            { "<leader>E", "<cmd>:NvimTreeFocus<cr>",  desc = "Explorer Nvim-Tree focus", remap = true },
        },
        --  setup with some options
        opts = {
            respect_buf_cwd = true,
            sync_root_with_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = true
            },
            sort_by = "case_sensitive",
            git = {
                enable = true,
            },
            view = {
                adaptive_size = true,
                hide_root_folder = false,
                --		width = 25,
                mappings = {
                    list = {
                        { key = "u", action = "dir_up" },
                    },
                },
            },
            filters = {
                dotfiles = true,
            },
            renderer = {
                highlight_git = true,
                icons = {
                    show = {
                        git = true,
                    },
                    glyphs = {
                        default = "",
                        symlink = "",
                        folder = {
                            default = "",
                            empty = "",
                            empty_open = "",
                            open = "",
                            symlink = "",
                            symlink_open = "",
                            arrow_open = "",
                            arrow_closed = "",
                        },
                        git = {
                            unstaged = "",
                            staged = "✓",
                            unmerged = "",
                            renamed = "➜",
                            untracked = "★",
                            deleted = " ",
                            ignored = "◌",
                        },
                    },
                },
            },
            diagnostics = {
                enable = false,
                show_on_dirs = false,
                show_on_open_dirs = true,
                debounce_delay = 50,
                severity = {
                    min = vim.diagnostic.severity.HINT,
                    max = vim.diagnostic.severity.ERROR,
                },
                icons = {
                    hint = "",
                    info = "",
                    warning = "",
                    error = "",
                },
            },
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            },
        },
    },
}
