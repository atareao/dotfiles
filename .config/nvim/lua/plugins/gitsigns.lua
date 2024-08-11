return {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    opts = {
        signs = {
            --add          = { text = '➕'},
            --change       = { text = '|'},
            delete       = { text = '➖'},
            topdelete    = { text = '➖'},
            changedelete = { text = '🔥'},
            untracked    = { text = '❓'},
        }
    }
}
