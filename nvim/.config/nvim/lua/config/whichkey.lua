local M = {}

function M.setup()
  local whichkey = require "which-key"
	local builtin = require('telescope.builtin')

  local conf = {
    window = {
      border = "double", -- none, single, double, shadow
      position = "bottom", -- bottom, top
    },
  }

  local opts = {
    mode = "n", -- Normal mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local mappings = {
    ["w"] = { "<cmd>update!<CR>", " Guardar" },
    ["q"] = { "<cmd>q!<CR>", " Salir" },

    b = {
      name = " Buffer",
      c = { "<Cmd>bd!<Cr>", "Cerrar buffer" },
      D = { "<Cmd>%bd|e#|bd#<Cr>", "Borrar Todos buffers" },
    },

    z = {
      name = " Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
      p = { "<cmd>PackerProfile<cr>", "Profile" },
    },

    g = {
      name = " Git",
      s = { "<cmd>Neogit<CR>", "Status" },
    },
		f = {
  name = " Buscar",
 f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Archivos"},
 g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Live grep"},
 b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers"},
 h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help Tab"},
  o = { "<cmd>FzfLua oldfiles<cr>", "Old files" },
  c = { "<cmd>FzfLua commands<cr>", "Comandos" },
	n = { "<cmd>:Telescope file_browser<cr>", "File Browser" },
	p = { "<cmd>:lua require'telescope'.extensions.project.project{}<cr>", "Proyectos" },
},
  }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)
end

return M
