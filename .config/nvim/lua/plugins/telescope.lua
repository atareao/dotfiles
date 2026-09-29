return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-telescope/telescope-symbols.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-dap.nvim",
        "olacin/telescope-gitmoji.nvim",
        "xiyaowong/telescope-emoji.nvim",
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
            }
        }
	vim.schedule(function()
		require("telescope").load_extension("file_browser")
		require("telescope").load_extension("media_files")
		require("telescope").load_extension("fzy_native")
		require("telescope").load_extension("gitmoji")
		require("telescope").load_extension("emoji")
		require("telescope").load_extension("ui-select")
	end)
    end,
}
