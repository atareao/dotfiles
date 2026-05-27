return {
    'mrcjkb/rustaceanvim',
    version = '^6',
    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "rust",
            callback = function()
                vim.keymap.set("n", "<leader>a", function()
                    vim.cmd.RustLsp('codeAction')
                end, { silent = true, buffer = true })
                vim.keymap.set("n", "K", function()
                    vim.cmd.RustLsp({ 'hover', 'actions' })
                end, { silent = true, buffer = true })
            end,
        })
    end,
}
