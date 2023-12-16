return {
    "williamboman/mason-lspconfig.nvim", -- optional
    event = "VeryLazy",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim", -- optional
        "folke/lsp-colors.nvim",
        "jose-elias-alvarez/null-ls.nvim",
        "dense-analysis/ale",
    },
    config = function()
        servers = {
            "ansiblels", "bashls", "cssls", "dockerls",
            "docker_compose_language_service", "efm", "html", "jsonls",
            "tsserver", "jqls", "lua_ls", "marksman", "intelephense",
            "pyright", "pylyzer", "pylsp", "ruff_lsp", "sqlls", "taplo",
            "svelte"
        }
        local lspconfig = require("lspconfig")
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = servers,
            -- auto-install configured servers (with lspconfig)
            automatic_installation = true, -- not the same as ensure_installed
        })
        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup {
                -- on_attach = my_custom_on_attach,
                capabilities = capabilities,
            }
        end
        local null_ls = require('null-ls')
        null_ls.setup({
            sources = {
              -- snippets support
              null_ls.builtins.completion.luasnip
            },
        })

    end
}

