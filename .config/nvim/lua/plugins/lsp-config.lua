return {
    "williamboman/mason-lspconfig.nvim", -- optional
    event = "VeryLazy",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim", -- optional
        "folke/lsp-colors.nvim",
        "mfussenegger/nvim-lint",
    },
    config = function()
        local nvim_lsp = require('lspconfig')
        local servers = {
            ansiblels = {},
            bashls = {},
            cssls = {},
            dockerls = {},
            docker_compose_language_service = {},
            html = {},
            jsonls = {},
            tsserver = {},
            jqls = {},
            lua_ls = {},
            intelephense = {},
            pyright = {},
            pylyzer = {},
            pylsp = {},
            ruff_lsp = {},
            sqlls = {},
            taplo = {},
            svelte = {},
            typst_lsp = {
                Typst = {
                    exportPdf = "onSave",
                }
            }
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
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities()

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
            python = { 'golangcilint', 'flake8', 'ruff' },
            typescript = { 'eslint' },
        }
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end
}
