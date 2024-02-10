-----------------------------------------------------------
-- Autocomplete configuration file
-----------------------------------------------------------

-- Plugin: nvim-cmp
-- https://github.com/hrsh7th/nvim-cmp

return {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    dependencies = {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "f3fora/cmp-spell",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind-nvim",
        "rafamadriz/friendly-snippets",
        "SergioRibera/cmp-dotenv",
    },
    config = function()
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'
        local compare = require('cmp.config.compare')

        cmp.setup {
            -- load snippet support
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            -- completion settings
            completion = {
                completeopt = 'menuone,noselect,noinsert'
            },

            -- key mapping
            mapping = {
                ['<C-p>'] = cmp.mapping.select_prev_item {
                    behavior = cmp.SelectBehavior.Insert,
                },
                ['<C-n>'] = cmp.mapping.select_next_item {
                    behavior = cmp.SelectBehavior.Insert,
                },
                -- ['<CR>'] = cmp.mapping.confirm {
                --   behavior = cmp.ConfirmBehavior.Replace,
                --   select = true,
                -- },
                ['<CR>'] = cmp.mapping.confirm { select = false },
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.close(),

                -- Tab mapping
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },

            -- load sources, see: https://github.com/topics/nvim-cmp
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip', option = { use_show_condition = false } },
                { name = 'path' },
                { name = 'buffer' },
                { name = 'spell' },
                { name = "dotenv" },
                --{ name = 'cmp_tabnine' },
            },
            sorting = {
                priority_weight = 2,
                comparators = {
                    --require('cmp_tabnine.compare'),
                    compare.offset,
                    compare.exact,
                    compare.score,
                    compare.recently_used,
                    compare.kind,
                    compare.sort_text,
                    compare.length,
                    compare.order,
                },
            },
        }

        require("cmp").setup.filetype(
            { "dap-repl", "dapui-watched" },
            {
                sources = {
                    { name = "dap" },
                },
            }
        )
    end
}
