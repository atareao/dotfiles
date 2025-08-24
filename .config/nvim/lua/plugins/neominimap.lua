return {
    "Isrothy/neominimap.nvim",
    version = "v3.x.x",
    lazy = false, -- NOTE: NO NEED to Lazy load
    init = function()
        vim.opt.wrap = true
        vim.opt.sidescrolloff = 36 -- Set a large value
        vim.g.neominimap = {
            auto_enable = true,
            layout = "split", -- "float" or "split"
        }
    end,
}
