return {
    "dstein64/nvim-scrollview",
    opts = {
        excluded_filetypes = {'neo-tree'},
        current_only = true,
        base = 'buffer',
        column = 100,
        signs_on_startup = {'all'},
        diagnostics_severities = {vim.diagnostic.severity.ERROR}
    }
}
