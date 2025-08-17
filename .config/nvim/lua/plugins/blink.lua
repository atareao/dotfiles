return {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
        "rafamadriz/friendly-snippets",
        "mikavilpas/blink-ripgrep.nvim",
        "fang2hou/blink-copilot",
        "onsails/lspkind.nvim",
    },
    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        cmdline = { enabled = true },
        fuzzy = { implementation = "prefer_rust_with_warning" },
        keymap = {
            ['<tab>'] = {'select_accept_and_enter', 'fallback'}
        },
        sources = {
            default = { "minuet", "copilot", "lsp", "path", "snippets", "buffer", "ripgrep" },
            providers = {
                copilot = {
                    name = "copilot",
                    module = "blink-copilot",
                    score_offset = 100,
                    async = true,
                },
                ripgrep = {
                    module = "blink-ripgrep",
                    name = "Ripgrep",
                    -- see the full configuration below for all available options
                    ---@module "blink-ripgrep"
                    ---@type blink-ripgrep.Options
                    opts = {},
                },
                minuet = {
                    name = 'minuet',
                    module = 'minuet.blink',
                    async = true,
                    -- Should match minuet.config.request_timeout * 1000,
                    -- since minuet.config.request_timeout is in seconds
                    timeout_ms = 3000,
                    score_offset = 50, -- Gives minuet higher priority among suggestions
                },
                buffer = {
                    opts = {
                        -- get all buffers, even ones like neo-tree
                        -- get_bufnrs = vim.api.nvim_list_bufs
                        -- or (recommended) filter to only "normal" buffers
                        get_bufnrs = function()
                            return vim.tbl_filter(function(bufnr)
                                return vim.bo[bufnr].buftype == ''
                            end, vim.api.nvim_list_bufs())
                        end
                    }
                }
            },
        },
        appearance = {
            -- Blink does not expose its default kind icons so you must copy them all (or set your custom ones) and add Copilot
            kind_icons = {
                Copilot = "",
            }
        },
        signature = { enabled = true },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
                window = { border = "single" },
            },
            ghost_text = {
                enabled = true,
            },
            trigger = {
                show_on_keyword = true
            },
            list = {
                selection = { preselect = true, auto_insert = true }
            },
            menu = {
                boder = "single",
                draw = {
                    padding = { 1, 1 }, -- padding only on right side
                    treesitter = { "lsp" },
                    columns = { { "kind_icon" }, { "label", gap = 1 } },
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                local icon = ctx.kind_icon
                                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                                    if dev_icon then
                                        icon = dev_icon
                                    end
                                elseif ctx.kind == "Copilot" then
                                    icon = "🐙"
                                elseif ctx.kind == "Ripgrep" then
                                    icon = "🔍"
                                elseif ctx.kind == "minuet" then
                                    icon = "💃🏻"
                                elseif ctx.kind == "Minuet" then
                                    icon = "💃🏻"
                                else
                                    icon = require("lspkind").symbolic(ctx.kind, {
                                        mode = "symbol",
                                    })
                                end
                                return icon .. ctx.icon_gap
                            end,

                            -- Optionally, use the highlight groups from nvim-web-devicons
                            -- You can also add the same function for `kind.highlight` if you want to
                            -- keep the highlight groups in sync with the icons.
                            highlight = function(ctx)
                                local hl = ctx.kind_hl
                                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                    local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                                    if dev_icon then
                                        hl = dev_hl
                                    end
                                end
                                return hl
                            end,
                        },
                        label = {
                            text = function(ctx)
                                return require("colorful-menu").blink_components_text(ctx)
                            end,
                            highlight = function(ctx)
                                return require("colorful-menu").blink_components_highlight(ctx)
                            end,
                        },
                    }
                }
            }
        }
    },
    opts_extend = { "sources.default" }
}
