return {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-telescope/telescope-symbols.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-dap.nvim",
        "olacin/telescope-gitmoji.nvim",
    },
    config = function()
        require('telescope').setup{
            defaults = {
                -- Default configuration for telescope goes here:
                -- config_key = value,
                mappings = {
                    i = {
                        -- map actions.which_key to <C-h> (default: <C-/>)
                        -- actions.which_key shows the mappings for your picker,
                        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                        ["<C-h>"] = "which_key"
                    }
                }
            },
            pickers = {
                -- Default configuration for builtin pickers goes here:
                -- picker_name = {
                --   picker_config_key = value,
                --   ...
                -- }
                -- Now the picker_config_key will be applied every time you call this
                -- builtin picker
            },
            extensions = {
                workspaces = {
                    keep_insert = true,
                },
                live_grep_args,
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
                        vim.ui.input({ prompt = "Enter commit message: " .. emoji .. " "}, function(msg)
                            if not msg then
                                return
                            end
                            -- Insert text instead of emoji in message
                            local emoji_text = entry.value.text
                            vim.cmd(':G commit -m "' .. emoji_text .. ' ' .. msg .. '"')
                        end)
                    end,
                },
            }
        }
        require("telescope").load_extension("gitmoji")
        require("telescope").load_extension("flutter")

        -- Using Lua functions
        local opts = { noremap=true, silent=true }
        local map = vim.api.nvim_set_keymap
        --map('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', opts)
        map('n', '<leader>fc', '<cmd>lua require("telescope.builtin").commands()<cr>', opts)
        map('n', '<leader>fd', '<cmd>lua require("telescope.builtin").diagnostics()<cr>', opts)
        map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', opts)
        --map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts)
        map('n', '<leader>fgb', '<cmd>lua require("telescope.builtin").git_branches()<cr>', opts)
        map('n', '<leader>fgc', '<cmd>lua require("telescope.builtin").git_commits()<cr>', opts)
        map('n', '<leader>fgs', '<cmd>lua require("telescope.builtin").git_status()<cr>', opts)
        map('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>', opts)

        vim.keymap.set('n', '<leader>fg', require("telescope").extensions.live_grep_args.live_grep_args, { noremap = true })
        vim.keymap.set('n', '<leader>fb', require("telescope.builtin").buffers, opts)

    end,
}
