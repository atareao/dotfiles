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
        local servers = {
            ansiblels = {},
            bashls = {},
            cssls = {},
            dockerls = {},
            docker_compose_language_service = {},
            html = {},
            jsonls = {},
            jqls = {},
            lua_ls = {},
            intelephense = {},
            pyright = {},
            --pylyzer = {},
            pylsp = {},
            ruff_lsp = {},
            sqlls = {},
            taplo = {},
            svelte = {},
            --ts_ls = {},
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
        require('lspconfig').ruff_lsp.setup {
            init_options = {
                settings = {
                    -- Any extra CLI arguments for `ruff` go here.
                    args = {},
                }
            },
            commands = {
                RuffAutofix = {
                  function()
                    vim.lsp.buf.execute_command {
                      command = 'ruff.applyAutofix',
                      arguments = {
                        { uri = vim.uri_from_bufnr(0) },
                      },
                    }
                  end,
                  description = 'Ruff: Fix all auto-fixable problems',
                },
                RuffOrganizeImports = {
                  function()
                    vim.lsp.buf.execute_command {
                      command = 'ruff.applyOrganizeImports',
                      arguments = {
                        { uri = vim.uri_from_bufnr(0) },
                      },
                    }
                  end,
                  description = 'Ruff: Format imports',
                },
            },
        }
    end
}
