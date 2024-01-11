return {
    "danymat/neogen",
    -- event = "VeryLazy",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
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
    }
}
