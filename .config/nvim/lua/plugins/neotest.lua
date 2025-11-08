return {
    "nvim-neotest/neotest",
    -- event = "VeryLazy",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-plenary",
        "nvim-neotest/neotest-vim-test",
        "nvim-neotest/neotest-python",
        "rouge8/neotest-rust",
        "rcasia/neotest-bash",
    },
    config = function(_, opts)
        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    dap = { justMyCode = false },
                    args = { "--log-level", "DEBUG" },
                    runner = "unittest",
                    python = ".venv/bin/python",
                }),
                require("neotest-plenary"),
                require("neotest-rust")({
                    args = { "--no-capture" },
                    dap_adapter = "lldb",
                }),
                require("neotest-bash")
            },

        })
    end,
}
