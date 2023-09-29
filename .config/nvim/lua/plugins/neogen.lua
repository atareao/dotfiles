return {
    "danymat/neogen",
    event = "VeryLazy",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("neogen").setup({
            enabled = true,
            snippet_engine = "luasnip",
            languages = {
                python = {
                    template = {
                        annotation_convention = "numpydoc"
                    }
                },
            }
        })
    end,
    -- Uncomment next line if you want to follow only stable versions
    -- tag = "*"
    -- autocomplete
}
