return {
  {
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    { "luarocks.nvim" },
    event = "VeryLazy",
    ft = "http",
    --[[ keys = {
          { "<leader>rx", "<Plug>RestNvim<cr>",        desc = " Consultar API-rest" },
          { "<leader>rw", "<Plug>RestNvimPreview<cr>", desc = " Ver cUrl consulta" },
          { "<leader>rl", "<Plug>RestNvimLast<cr>",    desc = "勒 Reload Ultimo API-Rest" }, 
      }, ]]
    config = function()
      require("rest-nvim").setup({
        -- Open request results in a horizontal split
        result_split_horizontal = false,
        -- Keep the http file buffer above|left when split horizontal|vertical
        result_split_in_place = false,
        -- Skip SSL verification, useful for unknown certificates
        skip_ssl_verification = false,
        -- Encode URL before making request
        encode_url = true,
        -- Highlight request on run
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          -- toggle showing URL, HTTP info, headers at top the of result window
          show_url = true,
          show_http_info = true,
          show_headers = true,
          -- executables or functions for formatting response body [optional]
          -- set them to false if you want to disable them
          formatters = {
            json = "jq",
            html = function(body)
              return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
            end,
          },
        },
        -- Jump to request line on run
        jump_to_request = false,
        env_file = ".env",
        custom_dynamic_variables = {},
        yank_dry_run = true,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "http",
        callback = function()
          vim.keymap.set("n", "<leader>rx", require("rest-nvim").run, { desc = " Consultar API-rest" })
          vim.keymap.set("n", "<leader>rl", require("rest-nvim").last, { desc = "勒 Reload Ultimo API-Rest" })
        end,
      })
    end,
  },
  -- Instalar treesitter Parser para rest-nvim
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "http", "json" })
      end
    end,
  },
}
