-----------------------------------------------------------
-- Treesitter configuration file
-----------------------------------------------------------

-- Plugin: nvim-treesitter
--- https://github.com/nvim-treesitter/nvim-treesitter
return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/nvim-treesitter-refactor",
        "nvim-treesitter/nvim-treesitter-context",
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = {
                "vim", "regex", "lua", "bash", "markdown", "markdown_inline",
                "python", "rust", "sql", "php", "javascript", "http", "json",
                "commonlisp"
            },
            modules = {"Highlight", "ContextCommentString", "RainbowDelimiters", "IncrementalSelection", "TreeDocs"},
            sync_install = false,
            auto_install = true,
            ignore_install = { "haskell", "phpdoc" }, -- List of parsers
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "php", "markdown", "rust", "python" },
            },
            rainbow = {
                enable = true,
                -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
                extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                max_file_lines = nil, -- Do not enable for files with more than n lines, int
                -- colors = {}, -- table of hex strings
                -- termcolors = {} -- table of colour name strings
            },
            incremental_selection = {
                enable = false,
                keymaps = {
                    init_selection = '<CR>',
                    scope_incremental = '<CR>',
                    node_incremental = '<TAB>',
                    node_decremental = '<S-TAB>',
                },
            },
            indent = {
                enable = true,
                --disable = { "python" },
            },
            tree_docs = {
                enable = true,
            }
        })
    end
}
