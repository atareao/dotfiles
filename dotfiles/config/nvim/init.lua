--[[

  ██╗███╗   ██╗██╗████████╗██╗     ██╗   ██╗ █████╗
  ██║████╗  ██║██║╚══██╔══╝██║     ██║   ██║██╔══██╗
  ██║██╔██╗ ██║██║   ██║   ██║     ██║   ██║███████║
  ██║██║╚██╗██║██║   ██║   ██║     ██║   ██║██╔══██║
  ██║██║ ╚████║██║   ██║██╗███████╗╚██████╔╝██║  ██║
  ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝

Neovim init file

Version: 0.7.1_rev3 - 2021/10/09
Maintainer: Brainf+ck
Website: https://github.com/brainfucksec/neovim-lua

--]]

-----------------------------------------------------------
-- Import Lua modules
-----------------------------------------------------------
require('settings')                    -- settings
require('keymaps')                     -- keymaps
require('plugins/packer')              -- plugin manager

--require('plugins/nvim-tree')           -- filebrowser
require('plugins/neo-tree')           -- filebrowser
require('plugins/indent-blankline')    -- indentation

require('plugins/nvim-cmp')            -- autocomplete
require('plugins/nvim-autopairs')      -- autopairs
require('plugins/nvim-lspconfig')      -- LSP settings
require('plugins/vista')               -- tag viewer
require('plugins/nvim-treesitter')     -- tree-sitter interface
require('plugins/gitsigns')            -- git decorations
require('plugins/rust-tools')          -- autocomplete
require('plugins/telescope-nvim')      --
require('plugins/telescope-ui-select') --
--require('plugins/lualine')           -- statusline
require('plugins/feline')              -- statusline
require('plugins/tabby')               -- tabs

require('plugins/telescope-media-files')
require('plugins/sidebar-nvim')
require('plugins/ayu')
require('plugins/luasnip')
--require('plugins/tabnine')
require('plugins/trouble')
require('plugins/nvim-dap-ui')
