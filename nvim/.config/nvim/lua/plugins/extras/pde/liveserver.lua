local liveserver = require("config.utils")
return {
  {
    "barrett-ruth/live-server.nvim",
    -- event = "VeryLazy",
    build = "yarn global add live-server",
    config = true,
    keys = {
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
    },
  },
}
