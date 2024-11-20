return {
  "nvim-neotest/neotest",
  dependencies = { "nvim-neotest/nvim-nio", "olimorris/neotest-phpunit" },
  opts = {
    adapters = {
      require("neotest-phpunit"),
    },
    status = { virtual_text = true },
    output = { open_on_run = true },
    quickfix = {
      open = function()
        if LazyVim.has("trouble.nvim") then
          require("trouble").open({ mode = "quickfix", focus = false })
        else
          vim.cmd("copen")
        end
      end,
    },
  },
}
