-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    -- Automatically replaces a session within a terminal emulator buffer with
    -- the file/directory argumen speciefied
    "samjwill/nvim-unception",
    -- file explorer
    --use "kyazdani42/nvim-tree.lua"
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        lazy = false,
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim"
        },
        config = function()
            require("config.neo-tree")
        end,
    },
    {
        "sidebar-nvim/sidebar.nvim",
        config = function()
            require("config.sidebar-nvim")
        end,
    },
    -- indent line
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("config.indent-blankline")
        end,
    },
    -- autopair
    --use "windwp/nvim-autopairs"
    -- autoclose.
    {
        "m4xshen/autoclose.nvim",
        config = function()
            require("config.autoclose")
        end,
    },
    -- icons
    "kyazdani42/nvim-web-devicons",
    "adelarsq/vim-devicons-emoji",
    -- tagviewer
    {
        "liuchengxu/vista.vim",
        config = function()
                    require("config.vista")
        end,
    },
    -- treesitter interface
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = true,
        config = function()
            require("config.nvim-treesitter")
        end,
    },
    "nvim-treesitter/nvim-tree-docs",
    "p00f/nvim-ts-rainbow",

    -- colorschemes
    {
        "Shatur/neovim-ayu",
        config = function()
            require("config.ayu")
        end
    },
    "folke/neodev.nvim",
    -- LSP
    {
        "williamboman/mason-lspconfig",
        config = function()
            require("config.lsp.mason-lspconfig")
        end,
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("config.mason")
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("config.nvim-lspconfig")
        end,
    },
    -- Linter
    -- {
    --     "jose-elias-alvarez/null-ls.nvim",
    --     config = function()
    --         require("config.null-ls")
    --     end,
    -- },
    -- LSP
    {
        "lvimuser/lsp-inlayhints.nvim",
        config = function()
            require("lsp-inlayhints").setup()
        end
    },
    "folke/lsp-colors.nvim",
    {
        "folke/trouble.nvim",
        config = function()
            require("config.trouble")
        end,
        dependencies = {
            "kyazdani42/nvim-web-devicons",
        }
    },
    {
        "danymat/neogen",
        config = function()
            require('neogen').setup {}
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        }
        -- Uncomment next line if you want to follow only stable versions
        -- tag = "*"
        -- autocomplete
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("config.nvim-cmp")
        end,
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                event = "VeryLazy",
                -- follow latest release.
                --version = "v<CurrentMajor>.*",
                -- install jsregexp (optional!).
                build = "make install_jsregexp",
                config = function()
                    require("config.luasnip")
                end,
            },
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "f3fora/cmp-spell",
            "saadparwaiz1/cmp_luasnip",
        },
    },
    "rafamadriz/friendly-snippets",
    "onsails/lspkind-nvim",
    "Iron-E/nvim-highlite",
    {
        "freddiehaddad/feline.nvim",
        event = "VeryLazy",
        config = function()
            require("config.feline")
        end,
        dependencies = {
            "gitsigns.nvim",
            "nvim-web-devicons"
        },
    },
    -- cokeline - buffers
    {
        "noib3/nvim-cokeline",
        config = function()
            require("config.cokeline")
        end,
        dependencies = "kyazdani42/nvim-web-devicons",
    },
    -- TODO: remoxe
    -- FIX: fix

    -- fuzzy finder
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require("config.telescope-nvim")
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("config.telescope-ui-select")
        end,
    },
    "nvim-telescope/telescope-symbols.nvim",
    {
        "nvim-telescope/telescope-media-files.nvim",
        config = function()
            require("config.telescope-media-files")
        end,
    },
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-dap.nvim",
    "ibhagwan/fzf-lua",
    -- zettelkasten
    {
        "jakewvincent/mkdnflow.nvim",
        config = function()
            require("config.mkdnflow")
        end,
    },
    -- git labels
    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
          require("config.gitsigns")
        end,
    },
    -- help for git
    "kdheepak/lazygit.nvim",
    -- diffview
    {
        "sindrets/diffview.nvim",
        event = "VeryLazy",
        config = function()
            require("config.diffview")
        end,
        dependencies = "nvim-lua/plenary.nvim"
    },
    -- documentation
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("config.neogen")
        end,
        -- Uncomment next line if you want to follow only stable versions
        -- tag = "*"
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("config.todo-comments")
        end,
    },
    -- autosave
    {
        "Pocco81/auto-save.nvim",
        config = function()
            require("config.autosave")
        end
    },
    -- terminal
    {
        "nyngwang/NeoTerm.lua",
        config = function()
            require("config.neoterm")
        end,
    },
    -- rest
    {
        "NTBBloodbath/rest.nvim",
        config = function()
            require("config.rest")
        end,
        dependencies = "nvim-lua/plenary.nvim",
    },
    -- just
    "NoahTheDuke/vim-just",
    {
        "IndianBoy42/tree-sitter-just",
        config = function()
            require("tree-sitter-just").setup({})
        end
    },
    -- Whichkey
    {
        "folke/which-key.nvim",
        config = function()
            require("config.whichkey")
        end
    },

    -- rust
    {
        "simrat39/rust-tools.nvim",
        config = function()
            require("config.rust-tools")
        end,
    },
    {
        "mfussenegger/nvim-dap",
        config = function()
            require("config.dbg.init")
        end
    },
    "mfussenegger/nvim-dap-python",
    "rcarriga/nvim-dap-ui",
    {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
          require("nvim-dap-virtual-text").setup({
            enabled = true, -- enable this plugin (the default)
            enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
            highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
            highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
            show_stop_reason = true, -- show stop reason when stopped for exceptions
            commented = true, -- prefix virtual text with comment string
            only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
            all_references = false, -- show virtual text on all all references of the variable (not only definitions)
            filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
            -- experimental features:
            virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
            all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
            virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
            virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
            -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
          })
        end
    },
    {
    "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-plenary",
            "nvim-neotest/neotest-python",
            "nvim-neotest/neotest-vim-test"
        },
        config = function()
            require("config.nvim-neotest")
        end
    },
    "alker0/chezmoi.vim",
    "norcalli/nvim-colorizer.lua",
    "soywod/himalaya.vim",

    {
        "mrjones2014/legendary.nvim",
        config = function()
            require("config.legendary")
        end,
    },
    {
        "natecraddock/workspaces.nvim",
        config = function()
            require("config.workspaces")
        end,
    },
    "natecraddock/sessions.nvim",
    {
        "cshuaimin/ssr.nvim",
        config = function()
            require("config.ssr")
        end,
    },
    -- Notification
    --{
    --    "rcarriga/nvim-notify",
    --    config = function()
    --        vim.notify = require("notify")
    --    end,
    --},
    -- emoji
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    "stevearc/dressing.nvim",
    {
        "ziontee113/icon-picker.nvim",
        config = function()
            require("icon-picker").setup({
                disable_legacy_commands = true
            })
        end,
    },
    {
        "folke/noice.nvim",
        config = function()
            require("noice").setup({
                notify = {
                    view = "mini"
                },
                messages = {
                    view = "mini"
                },
                errors = {
                    view = "mini"
                }
            })
        end,
        dependencies = {
             "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup({
                background_colour = "#000000"
            })
        end
    },
    {
        "BlackLight/nvim-http"
    },
    {
        "ojroques/nvim-bufdel"
    },
    {
        "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        config = function()
            require("config.chatgpt")
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    }
})
