local TelescopePrompt = {
  TelescopeNormal = { bg = "#222430" },
  TelescopeBorder = {
    fg = "#222430",
    bg = "#222430",
  },
  TelescopePromptNormal = {
    fg = "#F8F8F2",
    bg = "#2d303e",
  },
  TelescopePromptBorder = {
    fg = "#2d303e",
    bg = "#2d303e",
  },
  TelescopePromptTitle = {
    fg = "#282A36",
    bg = "#ff7070",
  },
  TelescopePreviewTitle = {
    fg = "#282A36",
    bg = "#50fa7b",
  },
  TelescopeResultsTitle = {
    fg = "#70907b",
    bg = "#222430",
  },
}
for hl, col in pairs(TelescopePrompt) do
  vim.api.nvim_set_hl(0, hl, col)
end
return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        results_title = false,
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        borderchars = { " " },
        color_devicons = true,
      },
    },
  },

  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
        -- require("telescope").load_extension("flutter")
      end,
    },
  },
  {
    "telescope.nvim",
    keys = {
      {
        "<leader>gk",
        "<cmd>:Telescope conventional_commits<cr>",
        desc = "Conventional Commit",
      },
    },
    dependencies = {
      "olacin/telescope-cc.nvim",
      config = function()
        -- require("telescope").setup({
        --   extensions = {
        --     conventional_commits = {
        --       -- theme = "ivy", -- custom theme
        --       action = function(entry)
        --         -- entry = {
        --         --     display = "feat       A new feature",
        --         --     index = 7,
        --         --     ordinal = "feat",
        --         --     value = feat"
        --         -- }
        --         vim.print(entry)
        --       end,
        --       include_body_and_footer = false, -- Add prompts for commit body and footer
        --     },
        --   },
        -- })
        require("telescope").load_extension("conventional_commits")
      end,
    },
  },
-- require('telescope').load_extension 'remote-sshfs',
  -- {
  --   "telescope.nvim",
  --   keys =
  --   {
  --     {
  --       "<leader>te",
  --       "<cmd>:Telescope file_browser path=%:p:h select_buffer=true<cr>",
  --       desc = "Telescope File-Browser"
  --     }
  --   },
  --   dependencies = {
  --     "nvim-telescope/telescope-file-browser.nvim",
  --     config = function()
  --       require("telescope").setup {
  --         extensions = {
  --           file_browser = {
  --             -- theme = "ivy",
  --             -- disables netrw and use telescope-file-browser in its place
  --             hijack_netrw = true,
  --             mappings = {
  --               ["i"] = {
  --                 -- your custom insert mode mappings
  --               },
  --               ["n"] = {
  --                 -- your custom normal mode mappings
  --               },
  --             },
  --           },
  --         },
  --       }
  --
  --       require("telescope").load_extension("file_browser")
  --     end,
  --   },
  -- },
  -- {
  --   "telescope.nvim",
  --   keys = {
  --     {
  --       "<C-p>",
  --       "<cmd>lua require'telescope'.extensions.project.project{ display_type = 'full' }<cr>",
  --       desc = "Telescope Projets"
  --     }
  --   },
  --   dependencies = {
  --     "nvim-telescope/telescope-project.nvim",
  --     config = function()
  --       require('telescope').setup {
  --         extensions = {
  --           project = {
  --             base_dirs = {
  --               { '~/proyectos/', max_depth = 4 },
  --             },
  --             hidden_files = true, -- default: false
  --             -- theme = "ivy",
  --             order_by = "asc",
  --             results_title = false,
  --             search_by = "title",
  --             sync_with_nvim_tree = false, -- default false
  --           }
  --         }
  --       }
  --       require 'telescope'.load_extension('project')
  --     end,
  --   },
  -- },
}
