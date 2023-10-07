return {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    config = function()
        local null_ls = require("null-ls")
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        null_ls.setup({
            sources = {
                -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#diagnostics
                -- formatting
                null_ls.builtins.formatting.ruff,
                null_ls.builtins.formatting.shfmt, -- shell script formatting
                null_ls.builtins.formatting.prettier, -- markdown formatting
                -- diagnostics
                null_ls.builtins.diagnostics.shellcheck, -- shell script diagnostics
                null_ls.builtins.diagnostics.flake8, -- shell script diagnostics
                null_ls.builtins.diagnostics.ruff, -- shell script diagnostics
                null_ls.builtins.diagnostics.hadolint, -- docker diagnostics
                null_ls.builtins.diagnostics.jasolint, -- javascript diagnostics
                null_ls.builtins.diagnostics.markdownlint, -- markdown diagnostics
                null_ls.builtins.diagnostics.pycodestyle, -- markdown diagnostics
                null_ls.builtins.diagnostics.pydocstyle, -- markdown diagnostics
                -- completions
                null_ls.builtins.completion.spell,
            },
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr })
                        end,
                    })
                end
            end,
        })
    end
}

