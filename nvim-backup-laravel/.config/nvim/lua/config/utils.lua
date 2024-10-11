local M = {}
local icons = require("config.icons")

local status = icons.misc.Antenna .. "Go live"

M.liveserver = function(cmd)
  if cmd == "start" then
    vim.cmd("LiveServerStart")
    status = icons.misc.Antenna .. "ON"
  elseif cmd == "stop" then
    vim.cmd("LiveServerStop")
    status = icons.misc.Antenna .. "OFF"
  end
  return status
end

return M
