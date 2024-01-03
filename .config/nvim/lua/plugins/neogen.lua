return {
    "danymat/neogen",
    -- event = "VeryLazy",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("neogen").setup({
            enabled = true,
            snippet_engine = "luasnip",
            languages = {
                rust = {
                    template = {
                        annotation_convention = "rustdoc",
                    }
                },
                python = {
                    template = {
                        annotation_convention = "numpydoc",
                    }
                },
                javascript = {
                    template = {
                        annotation_convention = "tsdoc",
                    }
                },
                typescript = {
                    template = {
                        annotation_convention = "tsdoc",
                    }
                }
            }
        })
    end,
    -- Uncomment next line if you want to follow only stable versions
    -- tag = "*"
    -- autocomplete
}
