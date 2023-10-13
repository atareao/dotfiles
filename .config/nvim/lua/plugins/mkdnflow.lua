return {
    'jakewvincent/mkdnflow.nvim',
    ---- event = "VeryLazy",
    --rocks = 'luautf8', -- Ensures optional luautf8 dependency is installed
    config = function()
        require('mkdnflow').setup({
            perspective = {
                priority = "root",
                root_tell = "main.md"
            }
        })
    end
}
