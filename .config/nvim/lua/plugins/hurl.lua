return {
    "jellydn/hurl.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = "hurl",
    lazy = false,
    opts = {
        -- Show debugging info
        debug = false,
        -- Show notification on run
        show_notification = false,
        -- Show response in popup or split
        mode = "split",
        -- Default formatter
        formatters = {
            json = { 'jq' }, -- Make sure you have install jq in your system, e.g: brew install jq
            html = {
                'prettier', -- Make sure you have install prettier in your system, e.g: npm install -g prettier
                '--parser',
                'html',
            },
        },
    },
    -- keys = {
    --     -- Run API request
    --     { "<leader>HA", "<cmd>HurlRunner<CR>", desc = "Run All requests" },
    --     { "<leader>Ha", "<cmd>HurlRunnerAt<CR>", desc = "Run Api request" },
    --     { "<leader>He", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
    --     { "<leader>Hm", "<cmd>HurlToggleMode<CR>", desc = "Hurl Toggle Mode" },
    --     { "<leader>Hv", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbose mode" },
    --     -- Run Hurl request in visual mode
    --     { "<leader>h", ":HurlRunner<CR>", desc = "Hurl Runner", mode = "v" },
    -- },
}
