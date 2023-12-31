return {
    "williamboman/mason-lspconfig.nvim", -- optional
    event = "VeryLazy",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim", -- optional
        "folke/lsp-colors.nvim",
        "mfussenegger/nvim-lint"
    },
    config = function()
        local servers = {
            "ansiblels", "bashls", "cssls", "dockerls",
            "docker_compose_language_service", "html", "jsonls",
            "tsserver", "jqls", "lua_ls", "intelephense",
            "pyright", "pylyzer", "pylsp", "ruff_lsp", "sqlls", "taplo",
            "svelte"
        }
        local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
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
                capabilities = lsp_capabilities,
            }
        end
        require('lint').linters_by_ft = {
            markdown = {'vale',},
            python = {'golangcilint'},
        }
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
            require("lint").try_lint()
        end,
        })
    end
}

