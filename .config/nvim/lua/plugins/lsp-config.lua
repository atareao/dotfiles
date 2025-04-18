return {
    "williamboman/mason-lspconfig.nvim", -- optional
    lazy = false,
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim", -- optional
        "folke/lsp-colors.nvim",
        "mfussenegger/nvim-lint",
    },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
        local servers = {
            ansiblels = {},
            bashls = {},
            cssls = {},
            dockerls = {},
            docker_compose_language_service = {},
            html = {},
            jsonls = {},
            --tsserver = {},
            lua_ls = {
                Lua = {
                    diagnostics = { globals = { 'vim' } }
                }
            },
            pyright = {},
            --pylyzer = {
            --    python = {
            --        inlayHints = true,
            --        smartCompletion = true,
            --    }
            --},
            markdown_oxide = {
                capabilities = vim.tbl_deep_extend(
                    'force',
                    capabilities,
                    {
                        workspace = {
                            didChangeWatchedFiles = {
                                dynamicRegistration = true,
                            },
                        },
                    }
                ),
                on_attach = on_attach -- configure your on attach config
            },
            --pylyzer = {},
            ruff = {},
            sqlls = {},
            taplo = {},
        }
        require("mason").setup({
            ui = {
                border = "none",
                icons = {
                    package_installed = "◍",
                    package_pending = "◍",
                    package_uninstalled = "◍",
                },
            },
            log_level = vim.log.levels.INFO,
            max_concurrent_installers = 4,
        })

        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup({
            ensure_installed = vim.tbl_keys(servers),
        })
        local handlers = {
            ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        }

        mason_lspconfig.setup_handlers {
            function(server_name)
                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                    bundle_path = (servers[server_name] or {}).bundle_path,
                    root_dir = function()
                        return vim.loop.cwd()
                    end,
                    handlers = handlers
                }
            end,
        }
        require('lint').linters_by_ft = {
            python = { 'ruff' },
            typescript = { 'eslint' },
        }
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end
}
