return {
    "williamboman/mason-lspconfig.nvim", -- optional
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim", -- optional
        "folke/lsp-colors.nvim",
        "simrat39/inlay-hints.nvim"
    },
    config = function()
        local mason_status_ok, mason = pcall(require, "mason")
        if not mason_status_ok then
            return
        end

        local lsp_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
        if not lsp_status_ok then
            return
        end

        --local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
        --if not mason_null_ls_status then
        --    return
        --end

        local config = {
            -- enable virtual text
            virtual_text = true,
            update_in_insert = true,
            underline = true,
            severity_sort = true,
            float = {
                focusable = true,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
                -- width = 40,
            },
        }

        local lspconfig = require("lspconfig")
        lspconfig.pylyzer.setup({
            settings = {
                pylyzer = {
                    diagnostics = false,
                    inlayHints = true
                }
            }
        })

        vim.diagnostic.config(config)
        require("inlay-hints").setup()
        --local servers = {
        --    "rust_analyzer", "bashls", "efm", "html", "jsonls",
        --    "intelephense", "phpactor", "tsserver", "marksman", "pyright",
        --    "pylsp", "ruff_lsp", "sqlls"
        --}
        mason.setup()
        mason_lspconfig.setup({
            ensure_installed = servers,
            -- auto-install configured servers (with lspconfig)
            automatic_installation = true, -- not the same as ensure_installed
        })
        
        local servers = {
            efm = {},
            pyright = {},
            ruff_lsp = {},
            pylyzer = {
                settings = {
                    pylyzer = {
                        diagnostics = false,
                        inlayHints = true,
                        smartCompletion = true,
                    },
                },
            },
            pylsp = {},
        }

        mason_lspconfig.setup {
            ensure_installed = vim.tbl_keys(servers),
        }

        mason_lspconfig.setup_handlers {
            function(server_name)
                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                }
            end,
        }
        --------------------------------------------------------------------------------
-- activate each lsp in the list
--------------------------------------------------------------------------------
for _, lsp in ipairs(servers) do
    local generic_opts = {
       capabilities = capabilities,
       on_attach = handlers.on_attach,
       flags = { debounce_text_changes = 150 },
    }
    local specialized_opts = option_lookup[lsp]
    if specialized_opts == nil then
       lspconfig[lsp].setup(generic_opts)
    else
       local opts = vim.tbl_deep_extend(
           "force",
           generic_opts,
           specialized_opts
        )
        lspconfig[lsp].setup(opts)
    end
end
    end,
}

