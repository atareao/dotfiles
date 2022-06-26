-----------------------------------------------------------
-- Keymaps configuration file: keymaps of neovim
-- and plugins.
-----------------------------------------------------------

local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}
local cmd = vim.cmd

-----------------------------------------------------------
-- Neovim shortcuts:
-----------------------------------------------------------

-- clear search highlighting
map('n', '<leader>c', ':nohl<CR>', default_opts)

-- don't use arrow keys
map('', '<up>', '<nop>', {noremap = true})
map('', '<down>', '<nop>', {noremap = true})
map('', '<left>', '<nop>', {noremap = true})
map('', '<right>', '<nop>', {noremap = true})

map('i', '<C-h>', '<left>', default_opts)
map('i', '<C-j>', '<down>', default_opts)
map('i', '<C-k>', '<up>', default_opts)
map('i', '<C-l>', '<right>', default_opts)

-- fast saving with <leader> and s
map('n', '<leader>s', ':w<CR>', default_opts)
map('i', '<leader>s', '<C-c>:w<CR>', default_opts)

-- move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h', default_opts)
map('n', '<C-j>', '<C-w>j', default_opts)
map('n', '<C-k>', '<C-w>k', default_opts)
map('n', '<C-l>', '<C-w>l', default_opts)

-- close all windows and exit from neovim
map('n', '<leader>q', ':quitall<CR>', default_opts)

-----------------------------------------------------------
-- Applications & Plugins shortcuts:
-----------------------------------------------------------
-- open terminal
map('n', '<C-t>', ':Term<CR>', {noremap = true})
map('t', '<C-w>h', '<C-\\><C-n><C-w>h', {noremap = true})
map('t', '<C-w>j', '<C-\\><C-n><C-w>j', {noremap = true})
map('t', '<C-w>k', '<C-\\><C-n><C-w>k', {noremap = true})
map('t', '<C-w>l', '<C-\\><C-n><C-w>l', {noremap = true})
map('t', '<C-w><C-w>', '<C-\\><C-n><C-w><C-w>', {noremap = true})

--nvim-lazygit
map('n', '<C-g>', ':LazyGit<CR>', default_opts)       -- open/close

--nvim-fzf-lua
map('n', '<C-p>', ':FzfLua files<CR>', default_opts)       -- open/close

-- nvim-tree
map('n', '<C-n>', ':Neotree toggle<CR>', default_opts)       -- open/close
--map('n', '<leader>r', ':NvimTreeRefresh<CR>', default_opts)  -- refresh
--map('n', '<leader>n', ':NvimTreeFindFile<CR>', default_opts) -- search file

-- Vista tag-viewer
map('n', '<C-q>', ':Vista!!<CR>', default_opts)   -- open/close
map('i', '<C-q>', ':Vista!!<CR>', default_opts)   -- open/close
map('n', '<leader>m', ':Vista!!<CR>', default_opts)

map('n', '<leader>zf', ':lua require(\'telekasten\').find_notes()<CR>', default_opts)
map('n', '<leader>zd', ':lua require(\'telekasten\').find_daily_notes()<CR>', default_opts)
map('n', '<leader>zg', ':lua require(\'telekasten\').search_notes()<CR>', default_opts)
map('n', '<leader>zz', ':lua require(\'telekasten\').follow_link()<CR>', default_opts)
map('n', '<leader>zn', ':lua require(\'telekasten\').goto_today()<CR>', default_opts)

map('n', '<leader>zT', ':lua require(\'telekasten\').goto_today()<CR>', default_opts)
map('n', '<leader>zW', ':lua require(\'telekasten\').goto_thisweek()<CR>', default_opts)
map('n', '<leader>zw', ':lua require(\'telekasten\').find_weekly_notes()<CR>', default_opts)
map('n', '<leader>zn', ':lua require(\'telekasten\').new_note()<CR>', default_opts)
map('n', '<leader>zN', ':lua require(\'telekasten\').new_templated_note()<CR>', default_opts)
map('n', '<leader>zy', ':lua require(\'telekasten\').yank_notelink()<CR>', default_opts)
map('n', '<leader>zc', ':lua require(\'telekasten\').show_calendar()<CR>', default_opts)
map('n', '<leader>zC', ':CalendarT<CR>', default_opts)
map('n', '<leader>zi', ':lua require(\'telekasten\').paste_img_and_link()<CR>', default_opts)
map('n', '<leader>zt', ':lua require(\'telekasten\').toggle_todo()<CR>', default_opts)
map('n', '<leader>zb', ':lua require(\'telekasten\').show_backlinks()<CR>', default_opts)
map('n', '<leader>zF', ':lua require(\'telekasten\').find_friends()<CR>', default_opts)
map('n', '<leader>zI', ':lua require(\'telekasten\').insert_img_link({ i=true })<CR>', default_opts)
map('n', '<leader>zp', ':lua require(\'telekasten\').preview_img()<CR>', default_opts)
map('n', '<leader>zm', ':lua require(\'telekasten\').browse_media()<CR>', default_opts)
map('n', '<leader>za', ':lua require(\'telekasten\').show_tags()<CR>', default_opts)
map('n', '<leader>#',  ':lua require(\'telekasten\').show_tags()<CR>', default_opts)
map('n', '<leader>zr', ':lua require(\'telekasten\').rename_note()<CR>', default_opts)

map('n', '<leader>[',  ':lua require(\'telekasten\').insert_link()<CR>', default_opts)
map('n', '<leader>[[', ':lua require(\'telekasten\').insert_link({ i=true })<CR>', default_opts)
map('n', '<leader>zt', ':lua require(\'telekasten\').toggle_todo({ i=true })<CR>', default_opts)
map('n', '<leader>#',  ':lua require(\'telekasten\').show_tags({i = true})<CR>', default_opts)

map('n', '<leader>tf', ':Telescope file_browser<CR>', default_opts)
map('n', '<leader>ts', ':Telescope symbols<CR>', default_opts)

-- on hesitation, bring up the panel
map('n', '<leader>z', ':lua require(\'telekasten\').panel()<CR>', default_opts)
map('n', '<C-s>', ':SidebarNvimToggle<CR>', default_opts)

-- Trouble

map("n", "<leader>xx", "<cmd>Trouble<cr>", {silent = true, noremap = true})
map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", {silent = true, noremap = true})
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", {silent = true, noremap = true})
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", {silent = true, noremap = true})
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", {silent = true, noremap = true})
map("n", "gR", "<cmd>Trouble lsp_references<cr>", {silent = true, noremap = true})

-- dap
map('n', '<leader>dc', '<cmd>lua require"dap".continue()<CR>', default_opts)
map('n', '<leader>dsv', '<cmd>lua require"dap".step_over()<CR>', default_opts)
map('n', '<leader>dsi', '<cmd>lua require"dap".step_into()<CR>', default_opts)
map('n', '<leader>dso', '<cmd>lua require"dap".step_out()<CR>', default_opts)
map('n', '<leader>dtb', '<cmd>lua require"dap".toggle_breakpoint()<CR>', default_opts)
map('n', '<leader>dsbr', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', default_opts)
map('n', '<leader>dsbm', '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', default_opts)
map('n', '<leader>dro', '<cmd>lua require"dap".repl.open()<CR>', default_opts)
map('n', '<leader>drl', '<cmd>lua require"dap".repl.run_last()<CR>', default_opts)

-- telescope-dap
map('n', '<leader>dcc', '<cmd>lua require"telescope".extensions.dap.commands{}<CR>', default_opts)
map('n', '<leader>dco', '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>', default_opts)
map('n', '<leader>dlb', '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>', default_opts)
map('n', '<leader>dv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>', default_opts)
map('n', '<leader>df', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>', default_opts)

-- tabby
vim.api.nvim_set_keymap("n", "<leader>ta", ":$tabnew<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tc", ":tabclose<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>to", ":tabonly<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tn", ":tabn<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tp", ":tabp<CR>", { noremap = true })
-- move current tab to previous position
vim.api.nvim_set_keymap("n", "<leader>tmp", ":-tabmove<CR>", { noremap = true })
-- move current tab to next position
vim.api.nvim_set_keymap("n", "<leader>tmn", ":+tabmove<CR>", { noremap = true })

-- Neogen
vim.api.nvim_set_keymap("n", "<leader>ng", ":lua require('neogen').generate()<CR>", { noremap = true })
