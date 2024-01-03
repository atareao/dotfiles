return {
    "dinhhuy258/git.nvim",
    event = "VeryLazy",
    config = function()
        require("git").setup()
    end,
}
