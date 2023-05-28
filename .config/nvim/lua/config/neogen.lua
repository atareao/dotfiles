require("neogen").setup({
    enabled = true,
    snippet_engine = "luasnip",
    languages = {
        python = {
            template = {
                annotation_convention = "reST"
            }
        },
    }
})
