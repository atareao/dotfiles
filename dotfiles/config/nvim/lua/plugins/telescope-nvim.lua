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
        }
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

-- Using Lua functions
local opts = { noremap=true, silent=true }
local map = vim.api.nvim_set_keymap
map('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', opts)
map('n', '<leader>fc', '<cmd>lua require("telescope.builtin").commands()<cr>', opts)
map('n', '<leader>fd', '<cmd>lua require("telescope.builtin").diagnostics()<cr>', opts)
map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', opts)
map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts)
map('n', '<leader>fgb', '<cmd>lua require("telescope.builtin").git_branches()<cr>', opts)
map('n', '<leader>fgc', '<cmd>lua require("telescope.builtin").git_commits()<cr>', opts)
map('n', '<leader>fgs', '<cmd>lua require("telescope.builtin").git_status()<cr>', opts)
map('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>', opts)
