local liveserver_status = require("config.utils")
local icons = require("config.icons")
local colors = {
  bg = "#202328",
  fg = "#bbc2cf",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
}
-- Icons and colors from mode_evil component
local mode_i = {
  n = "󰣇 ",
  i = " ",
  c = " ",
  v = " ",
}
local mode_c = function()
  -- auto change color according to neovims mode
  local mode_color = {
    n = colors.red,
    i = colors.green,
    v = colors.blue,
    c = colors.magenta,
    no = colors.red,
    s = colors.orange,
    S = colors.orange,
    ic = colors.yellow,
    R = colors.violet,
    Rv = colors.violet,
    cv = colors.red,
    ce = colors.red,
    r = colors.cyan,
    rm = colors.cyan,
    t = colors.red,
  }
  return { fg = mode_color[vim.fn.mode()] }
end
--
local function fg(name)
  return function()
    local hl = vim.api.nvim_get_hl_by_name(name, true)
    return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
  end
end

return {
  mode_evil = {
    function()
      return mode_i[vim.fn.mode()]
    end,
    color = mode_c,
    padding = { right = 1 },
  },
  position = {
    function()
      local lin = vim.fn.line(".")
      local col = vim.fn.col(".")
      return "ln " .. lin .. ", col " .. col
    end,
  },
  spaces = {
    function()
      local shiftwidth = vim.api.nvim_get_option_value("shiftwidth", { buf = 0 })
      return icons.ui.Tab .. " " .. shiftwidth
    end,
  },
  git_repo = {
    function()
      if vim.fn.trim(vim.fn.system("git rev-parse --is-inside-work-tree")) == "true" then
        return icons.misc.Repo .. "" .. vim.fn.trim(vim.fn.system("basename `git rev-parse --show-toplevel`"))
      end
      return ""
    end,
  },
  separator = {
    function()
      return "%="
    end,
  },
  diff = {
    "diff",
    colored = true,
    symbols = {
      added = icons.git.LineAdded,
      modified = icons.git.LineModified,
      removed = icons.git.LineRemoved,
    },
  },
  diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    diagnostics_color = {
      error = "DiagnosticError",
      warn = "DiagnosticWarn",
      info = "DiagnosticInfo",
      hint = "DiagnosticHint",
    },
    colored = true,
  },
  lsp_client = {
    function(msg)
      msg = msg or ""
      local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })

      if next(buf_clients) == nil then
        if type(msg) == "boolean" or #msg == 0 then
          return ""
        end
        return msg
      end

      local buf_ft = vim.bo.filetype
      local buf_client_names = {}

      -- add client
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
          table.insert(buf_client_names, client.name)
        end
      end

      -- add formatter
      local lsp_utils = require("plugins.extras.ui.statusline.utils")
      local formatters = lsp_utils.list_formatters(buf_ft)
      vim.list_extend(buf_client_names, formatters)

      -- add linter
      local linters = lsp_utils.list_linters(buf_ft)
      vim.list_extend(buf_client_names, linters)

      -- add hover
      local hovers = lsp_utils.list_hovers(buf_ft)
      vim.list_extend(buf_client_names, hovers)

      -- add code action
      local code_actions = lsp_utils.list_code_actions(buf_ft)
      vim.list_extend(buf_client_names, code_actions)

      local hash = {}
      local client_names = {}
      for _, v in ipairs(buf_client_names) do
        if not hash[v] then
          client_names[#client_names + 1] = v
          hash[v] = true
        end
      end
      table.sort(client_names)
      return icons.ui.Tool .. "" .. table.concat(client_names, ",") -- return table.concat(client_names, ", ")
    end,
    -- icon = icons.ui.Code,
    color = { fg = colors.fg },
    on_click = function()
      vim.cmd([[LspInfo]])
    end,
  },
  noice_mode = {
    function()
      return require("noice").api.status.mode.get()
    end,
    cond = function()
      return package.loaded["noice"] and require("noice").api.status.mode.has()
    end,
    color = fg("Constant"),
  },
  noice_command = {
    function()
      return require("noice").api.status.command.get()
    end,
    cond = function()
      return package.loaded["noice"] and require("noice").api.status.command.has()
    end,
    color = fg("Statement"),
  },
  venv = {
    function()
      local clients = {}
      local icon = icons.kind.Python
      local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
      local pyv = vim.fn.trim(vim.fn.system("python -V | cut -c 8-13"))

      for _, client in pairs(buf_clients) do
        if client.name == "pyright" then
          -- Check if lsp was initialized with py_lsp
          if client.config.settings.python["pythonPath"] ~= nil then
            local venv_name = client.config.settings.python.venv_name
            clients[#clients + 1] = icon .. venv_name .. " " .. pyv
          end
          -- else
          --   clients[#clients + 1] = icon .. client.name
        end
      end
      return table.concat(clients, " ")
    end,
    color = { fg = colors.orange },
    on_click = function()
      vim.cmd([[PyLspCurrentVenv]])
     end,
  },
  liveserver = {
    function()
      local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
      local set = {}
      local function make_set(array)
        for _, val in ipairs(array) do
          set[val] = true
        end
        return set
      end
      set = make_set({ "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" })
      if set[filetype] then
        return liveserver_status.liveserver()
      end
      return ""
    end,
    colored = true,
  },
  pyversion = {
    function()
      local pyv = vim.fn.trim(vim.fn.system("python -V | cut -c 8-13"))
      return pyv
    end,
  },
  flutter = {
    function()
      return vim.g.flutter_tools_decorations.app_version
    end,
    color = { fg = colors.blue },
  }
}
