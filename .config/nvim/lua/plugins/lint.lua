return {
    "mfussenegger/nvim-lint",
    -- event = "VeryLazy",
    config = function()
        require("lint").linters_by_ft = {
            lua = { "luacheck" },
            python = { "ruff" },
            javascript = { "eslint" },
            typescript = { "eslint" },
            go = { "golangci_lint" },
            rust = { "cargo_check" },
        }

        -- Auto lint on save
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}

