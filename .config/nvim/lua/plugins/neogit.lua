return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",     -- required
        "sindrets/diffview.nvim",    -- optional - Diff integration
        "nvim-telescope/telescope.nvim", -- optional
    },
    opts = {
        kind = "split_below_all",
    },
    config = true
}

