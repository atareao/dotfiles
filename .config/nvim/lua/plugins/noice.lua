return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
         "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function()
        require("noice").setup({
            notify = {
                view = "mini"
            },
            messages = {
                view = "mini"
            },
            errors = {
                view = "mini"
            }
        })
    end,
}
