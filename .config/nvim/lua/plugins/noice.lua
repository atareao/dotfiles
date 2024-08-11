return {
    "folke/noice.nvim",
    -- event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    opts = {
        notify = {
            view = "mini"
        },
        messages = {
            view = "mini"
        },
        errors = {
            view = "mini"
        },
        routes = {
            {
                filter = {
                    event = 'msg_show',
                    kind = '',
                    find = 'more line',
                },
                opts = { skip = true },
            },
        }
    }
}
