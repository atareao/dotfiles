return {
    "simrat39/rust-tools.nvim",
    -- event = "VeryLazy",
    config = function()
        require("rust-tools").setup()
    end,
}
