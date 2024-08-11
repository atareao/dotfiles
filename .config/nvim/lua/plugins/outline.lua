return {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { -- Example mapping to toggle outline
        { "<leader>O", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
        -- Your setup opts here
    },
    config = true,
}
