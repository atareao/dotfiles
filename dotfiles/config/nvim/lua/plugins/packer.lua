-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README
--- neovim-lua/README.md
--- https://github.com/brainfucksec/neovim-lua#readme


local cmd = vim.cmd
cmd [[packadd packer.nvim]]

local packer = require 'packer'

-- Add packages
return packer.startup(function()

-- file explorer
use 'kyazdani42/nvim-tree.lua'

-- indent line
use 'lukas-reineke/indent-blankline.nvim'

-- autopair
use {
  'windwp/nvim-autopairs',
  config = function()
  require('nvim-autopairs').setup()
  end
}

-- icons
use 'kyazdani42/nvim-web-devicons'

-- tagviewer
use 'liuchengxu/vista.vim'

-- treesitter interface
use 'nvim-treesitter/nvim-treesitter'

-- colorschemes
use 'Shatur/neovim-ayu'

use { 'rose-pine/neovim', as = 'rose-pine' }

-- LSP
use 'neovim/nvim-lspconfig'

-- Snippet engine
use 'hrsh7th/vim-vsnip'

-- autocomplete
use {
  'hrsh7th/nvim-cmp',
  requires = {
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-vsnip',
    'saadparwaiz1/cmp_luasnip',
  },
}

-- statusline
use {
  'glepnir/galaxyline.nvim',
  requires = { 'kyazdani42/nvim-web-devicons' },
}

-- fuzzy finder
use 'nvim-lua/popup.nvim'
use 'nvim-lua/plenary.nvim'
use 'nvim-telescope/telescope.nvim'

-- git labels
use {
  'lewis6991/gitsigns.nvim',
  requires = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('gitsigns').setup()
  end
}

-- rust
use 'simrat39/rust-tools.nvim'
use 'mfussenegger/nvim-dap'
use 'rcarriga/nvim-dap-ui'
end)
