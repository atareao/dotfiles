
return {
    "williamboman/mason-lspconfig",
    event = "VeryLazy",
    config = function()
        -- List of servers: https://github.com/williamboman/mason-lspconfig.nvim
        local mason_status_ok, mason = pcall(require, "mason")
        if not mason_status_ok then
            return
        end

        local lsp_status_ok, mason_lsp = pcall(require, "mason-lspconfig")
        if not lsp_status_ok then
            return
        end

        --local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
        --if not mason_null_ls_status then
        --    return
        --end

        local config = {
            -- disable virtual text
            virtual_text = false,
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

        vim.diagnostic.config(config)
        mason.setup()

        mason_lsp.setup({
            -- list of servers for mason to install
            ensure_installed = {
                "bashls",
                "efm",
                "jsonls",
                "tsserver",
                "intelephense",
                "pyright",
                "rust_analyzer",
            },
            -- auto-install configured servers (with lspconfig)
            automatic_installation = true, -- not the same as ensure_installed
        })

        -- mason_null_ls.setup({
        --     -- list of formatters & linters for mason to install
        --     ensure_installed = {
        --         "prettier", -- ts/js formatter
        --         "stylua", -- lua formatter
        --         "eslint_d", -- ts/js linter
        --         "pylint", -- ts/js linter
        --         "black",
        --         "flake8",
        --         "isort",
        --     },
        --     -- auto-install configured formatters & linters (with null-ls)
        --     automatic_installation = true,
        -- })

        -- Ensure the servers above are installed
        local mason_lspconfig = require 'mason-lspconfig'

        local servers = {
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
    end
}
