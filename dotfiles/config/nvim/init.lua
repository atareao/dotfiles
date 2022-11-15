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
require('settings')                      -- settings
require('keymaps')                       -- keymaps
require('plugins/packer')                -- plugin manager
require('plugins/autosave')              -- autosave

require('plugins/ayu')                   -- theme
require('plugins/feline')                -- statusline
require('plugins/gitsigns')              -- git decorations
require('plugins/diffview')              -- git diffview
require('plugins/indent-blankline')      -- indentation
require('plugins/luasnip')               -- snippets
require('plugins/neo-tree')              -- filebrowser
require('plugins/neogen')                -- documentation
require('plugins/nvim-autopairs')        -- autopairs
require('plugins/nvim-cmp')              -- autocomplete
require('plugins/nvim-dap-ui')           -- debug
require('plugins/nvim-lspconfig')        -- LSP settings
require('plugins/nvim-treesitter')       -- tree-sitter interface
require('plugins/rust-tools')            -- rust tools
require('plugins/sidebar-nvim')          -- sidebar
require('plugins/cokeline')              -- buffers
require('plugins/telescope-media-files') -- telescope media files
require('plugins/telescope-nvim')        -- telescope
require('plugins/telescope-ui-select')   -- telescope select
require('plugins/trouble')               -- errors manager
require('plugins/vista')                 -- tag viewer
require('plugins/mkdnflow')              -- markdown flow
require('plugins/neoterm')
require('plugins/rest')
require('plugins/todo-comments')
require('plugins/workspaces')
require('plugins/sessions')
require('plugins/legendary')

require('dbg')                           -- debug
