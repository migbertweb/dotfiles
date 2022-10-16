local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
 profile = {
    enable = true,
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
		display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end
------------------------------------------------------------------------------
  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }
------------------------------------------------------------------------------
-- Telescope
use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} },
  config = function()
   require("config.telescope").setup()
  end,
}
use { "nvim-telescope/telescope-file-browser.nvim" }
use { "nvim-telescope/telescope-project.nvim" }

-- Buffer line
use {
  "akinsho/nvim-bufferline.lua",
  event = "BufReadPre",
  wants = "nvim-web-devicons",
  config = function()
    require("config.bufferline").setup()
  end,
}

-- Colorscheme
use {
"folke/tokyonight.nvim",
config = function()
	vim.cmd "colorscheme tokyonight"
	require("tokyonight").setup {
  style = "night",
  styles = {
  comments = { italic = true },
    keywords = { italic = true },
    functions = { bold = true },
		sidebars = "dark",
  },
  sidebars = { "qf", "vista_kind", "terminal", "packer" },
  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  on_colors = function(colors)
    colors.hint = colors.orange
    colors.error = "#ff0000"
	end,
	}
end,
}
-- use {
-- "EdenEast/nightfox.nvim",
-- config = function()	
-- 	require("nightfox").setup {
-- 		options = { 	transparent = true, 
--     terminal_colors = true,
--
--     styles = {
--       comments = "italic",
--       keywords = "bold",
--       types = "italic,bold",
-- 			conditionals = "NONE",
--       constants = "italic",
--       functions = "bold",
--       numbers = "NONE",
--       operators = "italic,bold",
--       strings = "NONE",
--       variables = "italic,bold",
--     }
--   }
-- 	}
-- 	vim.cmd "colorscheme nordfox"
-- end,
-- }
--
-- use {
-- 	"dracula/vim",
-- 	config = function()
-- 		vim.cmd "colorscheme dracula"
-- 		vim.g.dracula_italic = true
-- 		vim.g.dracula_bold = true
-- 	end,
-- }
--
-- Estatusline con Lualine
use {
  "nvim-lualine/lualine.nvim",
  event = "VimEnter",
  config = function()
   require("config.lualine").setup()
  end,
  requires = { "nvim-web-devicons" },
}
use {
  "SmiteshP/nvim-gps",
  requires = "nvim-treesitter/nvim-treesitter",
  module = "nvim-gps",
  config = function()
    require("nvim-gps").setup()
  end,
}
-- FZF find file
use {
 "ibhagwan/fzf-lua",
  requires = { "kyazdani42/nvim-web-devicons" },
}
-- Treesitter support
use {
  "nvim-treesitter/nvim-treesitter",
   run = ":TSUpdate",
   config = function()
     require("config.treesitter").setup()
   end,
}
use {
  "SmiteshP/nvim-navic",
--  requires = "neovim/nvim-lspconfig"
}
-- Startup screen
    use {
      "goolord/alpha-nvim",
      config = function()
        require("config.alpha").setup()
      end,
    }

    -- Git
    use {
      "TimUntersberger/neogit",
			cmd = "Neogit",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("config.neogit").setup()
      end,
    }

		-- WhichKey
use {
   "folke/which-key.nvim",
	 event = "VimEnter",
   config = function()
     require("config.whichkey").setup()
   end,
requires = { "nvim-web-devicons" },
 }

-- IndentLine
use {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
  config = function()
    require("config.indentblankline").setup()
  end,
}
 -- Load only when require
    use { "nvim-lua/plenary.nvim", module = "plenary" }

    -- Better icons
    use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end,
    }

    -- Better Comment
    use {
      "numToStr/Comment.nvim",
      opt = true,
      keys = { "gc", "gcc", "gbc" },
      config = function()
        require("Comment").setup {}
      end,
    }

    -- Easy hopping
    use {
      "phaazon/hop.nvim",
      cmd = { "HopWord", "HopChar1" },
      config = function()
        require("hop").setup {}
      end,
    }

    -- Easy motion
    use {
      "ggandor/lightspeed.nvim",
      keys = { "s", "S", "f", "F", "t", "T" },
      config = function()
        require("lightspeed").setup {}
      end,
    }
		
    -- Markdown
    use {
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      ft = "markdown",
      cmd = { "MarkdownPreview" },
    }

--------------
--------------
    if packer_bootstrap then
      print "Reiniciar Neovim despues de finalizar la Instalacion de Plugins!"
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
