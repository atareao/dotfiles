return {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-telescope/telescope-symbols.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-dap.nvim",
        "olacin/telescope-gitmoji.nvim",
        "xiyaowong/telescope-emoji.nvim",
        "LinArcX/telescope-command-palette.nvim",
        "nvim-telescope/telescope-fzy-native.nvim",
        "nvim-telescope/telescope-media-files.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
        local lga_actions = require("telescope-live-grep-args.actions")
        require('telescope').setup {
            defaults = {
                mappings = {
                    i = {
                        ["<C-h>"] = "which_key"
                    }
                },
                file_ignore_patterns = { "node_modules/.*", ".git/.*", "dist/.*", ".yarn/.*", ".docker-volumes/.*" },
                dynamic_preview_title = true,
                path_display = { "truncate" },
            },
            pickers = {},
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({})
                },
                media_files = {
                    filetypes = { "png", "jpg", "mp4", "webm", "pdf" },
                    find_cmd = "rg",
                },
                workspaces = {
                    keep_insert = true,
                },
                live_grep_args = {
                    auto_quoting = true, -- enable/disable auto-quoting
                    mappings = {         -- extend mappings
                        i = {
                            ["<C-k>"] = lga_actions.quote_prompt(),
                            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                        },
                    },
                },
                gitmoji = {
                    action = function(entry)
                        -- entry = {
                        --   display = "🐛 Fix a bug.",
                        --   index = 4,
                        --   ordinal = "Fix a bug.",
                        --   value = {
                        --     description = "Fix a bug.",
                        --     text = ":bug:",
                        --     value = "🐛"
                        --   }
                        -- }
                        local emoji = entry.value.value
                        vim.ui.input({ prompt = "Enter commit message: " .. emoji .. " " }, function(msg)
                            if not msg then
                                return
                            end
                            local emoji_text = entry.value.text
                            vim.cmd(':G commit -m "' .. emoji_text .. ' ' .. msg .. '"')
                        end)
                    end,
                },
                command_palette = {
                    { "File",
                        { "entire selection (C-a)",  ':call feedkeys("GVgg")' },
                        { "save current file (C-s)", ':w' },
                        { "save all files (C-A-s)",  ':wa' },
                        { "quit (C-q)",              ':qa' },
                        { "file browser (C-i)",      ":lua require'telescope'.extensions.file_browser.file_browser()", 1 },
                        { "search word (A-w)",       ":lua require('telescope.builtin').live_grep()",                  1 },
                        { "git files (A-f)",         ":lua require('telescope.builtin').git_files()",                  1 },
                        { "files (C-f)",             ":lua require('telescope.builtin').find_files()",                 1 },
                    },
                    { "Help",
                        { "tips",            ":help tips" },
                        { "cheatsheet",      ":help index" },
                        { "tutorial",        ":help tutor" },
                        { "summary",         ":help summary" },
                        { "quick reference", ":help quickref" },
                        { "search help(F1)", ":lua require('telescope.builtin').help_tags()", 1 },
                    },
                    { "Code",
                        { "Preview markdown", ":Glow" },
                        { "Reformat code",    ":Reformat" }
                    },
                    { "Vim",
                        { "reload vimrc",              ":source $MYVIMRC" },
                        { 'check health',              ":checkhealth" },
                        { "jumps (Alt-j)",             ":lua require('telescope.builtin').jumplist()" },
                        { "commands",                  ":lua require('telescope.builtin').commands()" },
                        { "command history",           ":lua require('telescope.builtin').command_history()" },
                        { "registers (A-e)",           ":lua require('telescope.builtin').registers()" },
                        { "colorshceme",               ":lua require('telescope.builtin').colorscheme()",    1 },
                        { "vim options",               ":lua require('telescope.builtin').vim_options()" },
                        { "keymaps",                   ":lua require('telescope.builtin').keymaps()" },
                        { "buffers",                   ":Telescope buffers" },
                        { "search history (C-h)",      ":lua require('telescope.builtin').search_history()" },
                        { "paste mode",                ':set paste!' },
                        { 'cursor line',               ':set cursorline!' },
                        { 'cursor column',             ':set cursorcolumn!' },
                        { "spell checker",             ':set spell!' },
                        { "relative number",           ':set relativenumber!' },
                        { "search highlighting (F12)", ':set hlsearch!' },
                    }
                },
            }
        }
        require("telescope").load_extension("file_browser")
        require("telescope").load_extension("media_files")
        require("telescope").load_extension("fzy_native")
        require("telescope").load_extension("gitmoji")
        require("telescope").load_extension("emoji")
        require("telescope").load_extension("command_palette")
        require("telescope").load_extension("ui-select")
        require("telescope").load_extension("find_template")
    end,
}
