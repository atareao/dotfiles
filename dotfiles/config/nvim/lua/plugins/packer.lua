-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README
--- neovim-lua/README.md
--- https://github.com/brainfucksec/neovim-lua#readme

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  use 'wbthomason/packer.nvim'

  -- file explorer
  --use 'kyazdani42/nvim-tree.lua'
  use {
      'nvim-neo-tree/neo-tree.nvim',
      branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim"
    },
  }
  use 'sidebar-nvim/sidebar.nvim'

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
  use 'nvim-treesitter/nvim-tree-docs'
  use 'p00f/nvim-ts-rainbow'

  -- colorschemes
  use 'Shatur/neovim-ayu'
  use 'navarasu/onedark.nvim'

  use { 'rose-pine/neovim', as = 'rose-pine' }

  -- LSP
 use 'neovim/nvim-lspconfig'
 use {
    'folke/trouble.nvim',
    requires = {
        'kyazdani42/nvim-web-devicons',
    }
  }
  use 'kkoomen/vim-doge'

  -- autocomplete
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'f3fora/cmp-spell',
      'saadparwaiz1/cmp_luasnip',
    },
  }
  use 'rafamadriz/friendly-snippets'
  -- use {'tzachar/cmp-tabnine',
  --      run='./install.sh',
  --      requires = 'hrsh7th/nvim-cmp'
  -- }
  use {'onsails/lspkind-nvim'}


  -- statusline
  -- use {
  --   'nvim-lualine/lualine.nvim',
  --   requires = { 'kyazdani42/nvim-web-devicons' , opt = true},
  -- }
  use ('Iron-E/nvim-highlite')
  use {
     'feline-nvim/feline.nvim',
      requires = {
        'gitsigns.nvim',
        'nvim-web-devicons'
    },
  }

  -- tabs
  use {
    'nanozuki/tabby.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  -- fuzzy finder
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-ui-select.nvim'
  use 'nvim-telescope/telescope-symbols.nvim'
  use 'nvim-telescope/telescope-media-files.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'ibhagwan/fzf-lua'

  -- zettelkasten
  use 'renerocksai/telekasten.nvim'
  use 'renerocksai/calendar-vim'

  -- git labels
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup()
    end
  }
  -- help for git
  use 'kdheepak/lazygit.nvim'

  -- rust
  use 'simrat39/rust-tools.nvim'
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'

  use 'norcalli/nvim-colorizer.lua'
  require'colorizer'.setup()

  if packer_bootstrap then
    require('packer').sync()
  end
end)
