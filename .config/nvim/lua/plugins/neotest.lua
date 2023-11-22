return {
    "nvim-neotest/neotest",
    -- event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-plenary",
        "nvim-neotest/neotest-vim-test",
        "nvim-neotest/neotest-python",
        "rouge8/neotest-rust",
        "rcasia/neotest-bash",
    },
    config = function()
        require("neotest").setup({
          adapters = {
            require("neotest-python")({
                -- Extra arguments for nvim-dap configuration
                -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
                dap = { justMyCode = false },
                -- Command line arguments for runner
                -- Can also be a function to return dynamic values
                args = {"--log-level", "DEBUG"},
                -- Runner to use. Will use pytest if available by default.
                -- Can be a function to return dynamic value.
                runner = "unittest",
                -- Custom python path for the runner.
                -- Can be a string or a list of strings.
                -- Can also be a function to return dynamic value.
                -- If not provided, the path will be inferred by checking for 
                -- virtual envs in the local directory and for Pipenev/Poetry configs
                python = ".venv/bin/python",
                -- Returns if a given file path is a test file.
                -- NB: This function is called a lot so don't perform any heavy tasks within it.
                is_test_file = function(file_path)
                end,
            }),
            require("neotest-rust")({
                args = { "--no-capture"},
                dap_adapter = "lldb",
            }),
            require("neotest-bash")
          }
        })
        end
}
