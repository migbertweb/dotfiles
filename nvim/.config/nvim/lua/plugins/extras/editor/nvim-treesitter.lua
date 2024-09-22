return {
{
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "HiPhish/nvim-ts-rainbow2",
  },
  opts = {
    matchup = {
    enable = true,
include_match_words = true,
},
    rainbow = {
      enable = true,
      -- list of languages you want to disable the plugin for
      disable = { "cpp" },
      -- Which query to use for finding delimiters
      query = {
        "rainbow-parens",
        html = "rainbow-tags",
        latex = "rainbow-blocks",
        -- javascript = 'rainbow-parens-react',
        -- 'rainbow-tags-react',
      },
      -- Highlight the entire buffer all at once
      -- strategy = require('ts-rainbow').strategy.global,
    },
  },
},
{
"windwp/nvim-ts-autotag",
  event = "LazyFile",
  opts = {
aliases = {
    ["blade"] = "html",
  },
},
},
{
  "andymass/vim-matchup",
  setup = function()
 
  end,
},
}
