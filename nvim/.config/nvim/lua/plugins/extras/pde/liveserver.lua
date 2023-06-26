local liveserver = require("config.utils")
return {
  {
    "barrett-ruth/live-server.nvim",
    -- event = "VeryLazy",
    build = "yarn global add live-server",
--[[    keys = {
      {
        "<leader>cs",
        function()
          liveserver.liveserver("start")
        end,
        desc = "󱞒 LiveServer Start",
      },
      {
        "<leader>cx",
        function()
          liveserver.liveserver("stop")
        end,
        desc = "󱞐 LiveSrver Stop",
      },
    },--]]
    config = function ()
      vim.api.nvim_create_autocmd("FileType", {
    pattern = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    callback = function ()
        vim.keymap.set("n", "<leader>cs", function() liveserver.liveserver("start") end, { desc = "󱞒 LiveServer Start"})     
        vim.keymap.set("n", "<leader>cx", function() liveserver.liveserver("stop") end, { desc = "󱞐 LiveSrver Stop" })
    end
})
    end
  },
}
