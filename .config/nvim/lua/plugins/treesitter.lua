return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false, -- Use the latest commit
        branch = "main",
        build = ":TSUpdate",
        -- We set lazy = false and high priority because Telescope depends on it
        lazy = false,
        priority = 1000,
        -- Use 'opts' instead of 'config'. 
        -- Lazy.nvim will automatically call setup for you.
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "bash", "html", "javascript", "json", "lua", "markdown",
                "markdown_inline", "python", "query", "regex", "rust", "tsx",
                "typescript", "vim", "yaml", "dockerfile", "toml"
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        },
    },
}
