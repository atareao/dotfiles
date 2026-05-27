return {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
        require("lint").linters_by_ft = {
            lua = { "luacheck" },
            javascript = { "eslint" },
            typescript = { "eslint" },
            typescriptreact = { "eslint" },
            javascriptreact = { "eslint" },
            go = { "golangci_lint" },
            rust = { "cargo_check" },
            markdown = { "markdownlint" },
        }

        -- Auto lint on save
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}

