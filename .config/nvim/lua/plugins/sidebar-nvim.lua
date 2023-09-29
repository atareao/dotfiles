return {
    "sidebar-nvim/sidebar.nvim",
    event = "VeryLazy",
    config = function()
        require("sidebar-nvim").setup({
            open = false,
        })
    end,
}
