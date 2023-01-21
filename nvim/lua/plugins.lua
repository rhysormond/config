local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  }
end
vim.opt.runtimepath:prepend(lazypath)

local plugins = {
  -- ux improvements
  'tpope/vim-commentary', -- commands for (un)commenting lines
  'tpope/vim-surround', -- mappings for operating on surrounding text objects
  'tpope/vim-sleuth', -- automatic tabstop and shiftwidth automatically
  {
    -- git wrapper
    'tpope/vim-fugitive',
    dependencies = {
      'tpope/vim-rhubarb',
    },
  },

  -- ui improvements
  'savq/melange',
  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function() require 'gitsigns'.setup() end,
  },
  {
    'hoob3rt/lualine.nvim',
    config = function() require 'plugins.lualine' end,
  },

  -- language server
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      {
        'williamboman/mason.nvim',
        config = function() require 'mason'.setup() end,
      },
      {
        'williamboman/mason-lspconfig.nvim',
        config = function() require 'plugins.lspconfig' end,
      },

      -- Better LSP status updates
      {
        'j-hui/fidget.nvim',
        config = function() require 'fidget'.setup() end,
      },

      -- Configuration to work with the nvim API
      {
        'folke/neodev.nvim',
        config = function() require 'neodev'.setup() end,
      },
    },
  },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = function() pcall(require 'nvim-treesitter.install'.update { with_sync = true }) end,
    config = function() require 'plugins.nvim-treesitter' end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
  },

  -- autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function() require 'plugins.cmp' end,
  },

  -- fuzzy finding
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
    },
    config = function() require 'plugins.telescope' end,
  },
}


local opts = {
  -- replace nerd font symbols with unicode icons
  ui = {
    icons = {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      source = '📄',
      start = '🚀',
      task = '📌',
    },
  },
}

require('lazy').setup(plugins, opts)
