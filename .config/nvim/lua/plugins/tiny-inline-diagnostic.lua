return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    opts = {
        add_messages = {
            display_count = true,
        },
        multilines = {
            enabled = true,
            always_show = true,
        },
        show_source = {
            enabled = true,
        }
    },
}
