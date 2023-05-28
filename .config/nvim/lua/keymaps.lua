----------------------------------------------------------
-- Keymaps configuration file: keymaps of neovim
-- and plugins.
-----------------------------------------------------------

--local map = vim.api.nvim_set_keymap
local map = vim.keymap.set
local default_opts = {noremap = true, silent = true}
local cmd = vim.cmd

-----------------------------------------------------------
-- Neovim shortcuts:
-----------------------------------------------------------

-- clear search highlighting
map('n', '<leader>c', ':nohl<CR>', default_opts)
-- reload configuracion
map('n', '<leader>r', ':source % <CR>', default_opts)

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

map('n', '<leader>tf', ':Telescope file_browser<CR>', default_opts)
map('n', '<leader>ts', ':Telescope symbols<CR>', default_opts)

-- on hesitation, bring up the panel
map('n', '<C-s>', ':SidebarNvimToggle<CR>', default_opts)

-- Trouble

--map("n", "<leader>xx", "<cmd>Trouble<cr>", {silent = true, noremap = true})
-- map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", {silent = true, noremap = true})
-- map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", {silent = true, noremap = true})
-- map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", {silent = true, noremap = true})
-- map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", {silent = true, noremap = true})
-- map("n", "gR", "<cmd>Trouble lsp_references<cr>", {silent = true, noremap = true})

-- dap
map('n', '<leader>dui', '<cmd>lua require"dapui".toggle()<CR>', default_opts)
map('n', '<F5>', '<cmd>lua require"dap".continue()<CR>', default_opts)
map('n', '<F10>', '<cmd>lua require"dap".step_over()<CR>', default_opts)
map('n', '<F11>', '<cmd>lua require"dap".step_into()<CR>', default_opts)
map('n', '<S-F11>', '<cmd>lua require"dap".step_out()<CR>', default_opts)
map('n', '<F9>', '<cmd>lua require"dap".toggle_breakpoint()<CR>', default_opts)
map('n', '<F12>', '<cmd>lua require"dapui".eval(vim.fn.input "[Expression] > ")<CR>', default_opts)
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

-- cokeline
map('n', '<S-Tab>',   '<Plug>(cokeline-focus-prev)',  { silent = true })
map('n', '<Tab>',     '<Plug>(cokeline-focus-next)',  { silent = true })
map('n', '<Leader>p', '<Plug>(cokeline-switch-prev)', { silent = true })
map('n', '<Leader>n', '<Plug>(cokeline-switch-next)', { silent = true })

for i = 1,9 do
  map('n', ('<F%s>'):format(i),      ('<Plug>(cokeline-focus-%s)'):format(i),  { silent = true })
  map('n', ('<Leader>%s'):format(i), ('<Plug>(cokeline-focus-%s)'):format(i), { silent = true })
end

-- Neogen
map("n", "<leader>ng", ":lua require('neogen').generate()<CR>", { noremap = true })

-- ssr
vim.keymap.set({"n", "x"}, "<leader>sr", function() require("ssr").open() end)

-- noterm
local NOREF_NOERR_TRUNC = { noremap = true, silent = true, nowait = true }
map('n', '<M-Tab>', function ()
    if vim.bo.filetype == 'neo-tree' then return end
    vim.cmd('NeoTermOpen')
end, NOREF_NOERR_TRUNC)
map('t', '<M-Tab>', function () vim.cmd('NeoTermClose') end, NOREF_NOERR_TRUNC)
map('t', '<C-w>', function () vim.cmd('NeoTermEnterNormal') end, NOREF_NOERR_TRUNC)
map('t', '<M-w>', function () vim.cmd('NeoTermEnterNormal') end, NOREF_NOERR_TRUNC)
-- emoji
map("n", "<Leader>ei", "<cmd>IconPickerNormal<cr>", opts)
map("n", "<Leader>ey", "<cmd>IconPickerYank<cr>", opts) --> Yank the selected icon into register
map("i", "<C-e>", "<cmd>IconPickerInsert<cr>", opts)
