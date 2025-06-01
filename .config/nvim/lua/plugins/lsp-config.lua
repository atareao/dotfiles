return {
    "mason-org/mason-lspconfig.nvim", -- optional
    lazy = false,
    dependencies = {
        "neovim/nvim-lspconfig",
        {
            "mason-org/mason.nvim",
            opts = {
                ui = {
                    border = "none",
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    },
                },
                log_level = vim.log.levels.INFO,
                max_concurrent_installers = 4,
            }
        },
        {
            "folke/lsp-colors.nvim",
            opts = {
                Error = "#F44747",
                Warning = "#FF8800",
                Information = "#61AFEF",
                Hint = "#56B6C2"
            }
        },
        "mfussenegger/nvim-lint",
    },
    opts = {
        inlay_hints = { enabled = true },
    },
}
