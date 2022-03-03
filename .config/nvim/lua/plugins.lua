local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- ux improvements
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'

  -- ui improvements
  use 'savq/melange'
  use 'mhinz/vim-signify'
  use {
    'hoob3rt/lualine.nvim',
    config = function() require('plugins.lualine') end,
  }

  -- language server
  use {
    'neovim/nvim-lspconfig',
    config = function() require('plugins.lspconfig') end
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function() require('plugins.cmp') end,
  }
  use 'L3MON4D3/LuaSnip'

  -- fuzzy finding
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function() require('plugins.telescope') end,
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)