return {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            null_ls.builtins.formatting.shfmt, -- shell script formatting
            null_ls.builtins.formatting.prettier, -- markdown formatting
            null_ls.builtins.diagnostics.shellcheck, -- shell script diagnostics
        })
    end
}

