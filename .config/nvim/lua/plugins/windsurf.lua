return {
    'Exafunction/windsurf.vim',
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    opts = {
        workspace_root = {
            use_lsp = true,
            find_root = nil,
            paths = {
                ".bzr",
                ".git",
                ".hg",
                ".svn",
                "_FOSSIL_",
                "package.json",
            }
        },
        enable_cmp_source = true,
        vitual_text = {
            enabled = false,
        }
    },
    config = function()
    end
}
