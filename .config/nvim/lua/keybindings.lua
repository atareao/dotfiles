local keymap = function(mode, shortcut, command, description)
    vim.keymap.set(mode, shortcut, command, {desc =description, silent = true, noremap = true, nowait = true})
end
--
keymap("n", "<A-0>", "<cmd>BufferGoto 0<cr>", "Tab 0")
keymap("n", "<A-1>", "<cmd>BufferGoto 1<cr>", "Tab 1")
keymap("n", "<A-2>", "<cmd>BufferGoto 2<cr>", "Tab 2")
keymap("n", "<A-3>", "<cmd>BufferGoto 3<cr>", "Tab 3")
keymap("n", "<A-4>", "<cmd>BufferGoto 4<cr>", "Tab 4")
keymap("n", "<A-5>", "<cmd>BufferGoto 5<cr>", "Tab 5")
keymap("n", "<A-6>", "<cmd>BufferGoto 6<cr>", "Tab 6")
keymap("n", "<A-7>", "<cmd>BufferGoto 7<cr>", "Tab 7")
keymap("n", "<A-8>", "<cmd>BufferGoto 8<cr>", "Tab 8")
keymap("n", "<A-9>", "<cmd>BufferGoto 9<cr>", "Tab 9")
keymap("n", "<A-,>", "<cmd>BufferPrevious<cr>", "Previous Buffer")
keymap("n", "<A-.>", "<cmd>BufferNext<cr>", "Next Buffer")
keymap("n", "<A-c>", "<cmd>BufferClose<cr>", "Close Buffer")
keymap("n", "<A-p>", "<cmd>BufferPick<cr>", "Buffer Pick")
-- Bookmarks
keymap("n", "<leader>B", "", "Bookmarks")
keymap("n", "<leader>Ba", "<Plug>(cokeline-focus-prev)", "Annotate")
keymap("n", "<leader>Bc", "<cmd>silent BookmarkClear<cr>", "Clear")
keymap("n", "<leader>Bt", "<cmd>silent BookmarkToggle<cr>", "Toggle")
keymap("n", "<leader>Bm", '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon")
keymap("n", "<leader>Bn", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon Toggle")
keymap("n", "<leader>Bl", "<cmd>lua require('user.bfs').open()<cr>", "Buffers")
keymap("n", "<leader>Bj", "<cmd>silent BookmarkNext<cr>", "Next")
keymap("n", "<leader>Bs", "<cmd>Telescope harpoon marks<cr>", "Search Files")
keymap("n", "<leader>Bk", "<cmd>silent BookmarkPrev<cr>", "Prev")
keymap("n", "<leader>BS", "<cmd>silent BookmarkShowAll<cr>", "Prev")
keymap("n", "<leader>Bx", "<cmd>BookmarkClearAll<cr>", "Clear All")

--
keymap("n", "<leader>c", "<cmd>nohl<cr>", "Clear search higlighting")

-- Debug
keymap("n", "<leader>d", "", "Debug")
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint")
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", "Continue")
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", "Into")
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", "Over")
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", "Out")
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl")
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", "Last")
keymap("n", "<leader>dx", "<cmd>lua require'dap'.terminate()<cr>", "Exit")
keymap("n", "<leader>dt", "", "Telescope")
keymap("n", "<leadert>dtc", "<cmd>lua require'telescope'.extensions.dap.commands{}<CR>", "Telescope")
keymap("n", "<leadert>dto", "<cmd>lua require'telescope'.extensions.dap.configurations{}<CR>", "Telescope")
keymap("n", "<leadert>dtb", "<cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>", "Telescope")
keymap("n", "<leadert>dtv", "<cmd>lua require'telescope'.extensions.dap.variables{}<CR>", "Telescope")
keymap("n", "<leadert>dtf", "<cmd>lua require'telescope'.extensions.dap.frames{}<CR>", "Telescope")
keymap("n", "<leader>du", "", "dap-ui")
keymap("n", "<leader>dus", "<cmd>lua require'dapui'.setup()<cr>", "Setup")
keymap("n", "<leader>duo", "<cmd>lua require'dapui'.open()<cr>", "Open")
keymap("n", "<leader>duc", "<cmd>lua require'dapui'.close()<cr>", "Close")
keymap("n", "<leader>dut", "<cmd>lua require'dapui'.toggle()<cr>", "Toggle")

-- Documentation
keymap("n", "<leader>D", "", "Documentation")
keymap("n", "<leader>Dd", "<cmd>lua require'neogen'.generate()<cr>", "Generate documentation")

-- Find/Focus

keymap("n", "<leader>f", "", "Find/Focus")
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", "Find in buffers")
keymap("n", "<leader>fc", "<cmd>Telescope colorscheme<cr>", "Colorscheme")
keymap("n", "<leader>fd", "<cmd>Telescope gitmoji<cr>", "Gitmoji")
keymap("n", "<leader>fe", "<cmd>Telescope emoji<cr>", "Emojis")
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", "Find File")
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", "Live grep")
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", "Help")
keymap("n", "<leader>fi", "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media")
keymap("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", "Keymaps")
keymap("n", "<leader>fl", "<cmd>Telescope resume<cr>", "Last Search")
keymap("n", "<leader>fn", "<Plug>(cokeline-switch-next)", "Focus next")
keymap("n", "<leader>fo", "<cmd>Telescope file_browser<cr>", "Commands")
keymap("n", "<leader>fp", "<Plug>(cokeline-switch-prev)", "Focus preview")
keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", "Recent File")
keymap("n", "<leader>fs", "<cmd>Telescope grep_string theme=ivy<cr>", "Find String")
keymap("n", "<leader>ft", "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text")
keymap("n", "<leader>fy", "<cmd>Telescope symbols<cr>", "Symbols")
keymap("n", "<leader>fC", "<cmd>Telescope commands<cr>", "Commands")
keymap("n", "<leader>fM", "<cmd>Telescope man_pages<cr>", "Man Pages")
keymap("n", "<leader>fR", "<cmd>Telescope registers<cr>", "Registers")

-- Git
keymap("n", "<leader>g", "", "Git")
keymap("n", "<leader>gg", "<cmd>LazyGit<cr>", "Lazygit")
keymap("n", "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk")
keymap("n", "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk")
keymap("n", "<leader>gl", "<cmd>GitBlameToggle<cr>", "Blame")
keymap("n", "<leader>gm", "<cmd>Telescope gitmoji<cr>", "Git emoji")
keymap("n", "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk")
keymap("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk")
keymap("n", "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer")
keymap("n", "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk")
keymap("n", "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk")
keymap("n", "<leader>go", "<cmd>Telescope git_status<cr>", "Open changed file")
keymap("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", "Checkout branch")
keymap("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", "Checkout commit")
keymap("n", "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", "Diff")
keymap("n", "<leader>gi", "<cmd>SidebarNvimToggle<cr>", "Toggle sidebar")
keymap("n", "<leader>gG", "", "Gist")
keymap("n", "<leader>gGa", "<cmd>Gist -b -a<cr>", "Create Anon")
keymap("n", "<leader>gGd", "<cmd>Gist -d<cr>", "Delete")
keymap("n", "<leader>gGf", "<cmd>Gist -f<cr>", "Fork")
keymap("n", "<leader>gGg", "<cmd>Gist -b<cr>", "Create")
keymap("n", "<leader>gGl", "<cmd>Gist -l<cr>", "List")
keymap("n", "<leader>gGp", "<cmd>Gist -b -p<cr>", "Create Private")

-- Hurl
keymap("n", "<leader>H", "", "Hurl")
keymap("n", "<leader>HA", "<cmd>HurlRunner<cr>", "Run All requests")
keymap("n", "<leader>Ha", "<cmd>HurlRunnerAt<cr>", "Run Api requests")
keymap("n", "<leader>He", "<cmd>HurlRunnerToEntry<cr>", "Run Api request to entry")
keymap("n", "<leader>Ht", "<cmd>HurlRunnerToggleMode<cr>", "Hurl Toggle Mode")
keymap("n", "<leader>Hv", "<cmd>HurlRunnerVerbose<cr>", "Run Api in verbose mode")
keymap("n", "<leader>Hh", ":HurlRunner<cr>", "Hurl Runner")

-- LSP
keymap("n", "<leader>l", "", "LSP")
keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action")
keymap("n", "<leader>lw", "<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics")
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format")
keymap("n", "<leader>lF", "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat")
keymap("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition")
keymap("n", "<leader>lG", "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration")
keymap("n", "<leader>li", "<cmd>LspInfo<cr>", "Info")
keymap("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", "Installer Info")
keymap("n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover")
keymap("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", "Next Diagnostic")
keymap("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", "Prev Diagnostic")
keymap("n", "<leader>lK", "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover")
keymap("n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action")
keymap("n", "<leader>lo", "<cmd>SymbolsOutline<cr>", "Outline")
keymap("n", "<leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix")
keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename")
keymap("n", "<leader>lR", "<cmd>TroubleToggle lsp_references<cr>", "References")
keymap("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols")
keymap("n", "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols")
keymap("n", "<leader>lt", '<cmd>lua require("user.functions").toggle_diagnostics()<cr>', "Toggle Diagnostics")
keymap("n", "<leader>lu", "<cmd>LuaSnipUnlinkCurrent<cr>", "Unlink Snippet")
keymap("n", "<leader>lx", "<cmd>TroubleToggle<cr>", "Diagnostics")

-- Neotree
keymap("n", "<C-n>", "<cmd>Neotree toggle<cr>", "NeoTree")

-- Options
keymap("n", "<leader>o", "", "Options")
keymap("n", "<leader>ow", '<cmd>lua require("user.functions").toggle_option("wrap")<cr>', "Wrap")
keymap("n", "<leader>or", '<cmd>lua require("user.functions").toggle_option("relativenumber")<cr>', "Relative")
keymap("n", "<leader>ol", '<cmd>lua require("user.functions").toggle_option("cursorline")<cr>', "Cursorline")
keymap("n", "<leader>os", '<cmd>lua require("user.functions").toggle_option("spell")<cr>', "Spell")
keymap("n", "<leader>ot", '<cmd>lua require("user.functions").toggle_tabline()<cr>', "Tabline")

-- Lazy
keymap("n", "<leader>p", "", "Options")
keymap("n", "<leader>pc", "<cmd>Lazy check<cr>", "Check")
keymap("n", "<leader>pC", "<cmd>Lazy clean<cr>", "Clean")
keymap("n", "<leader>pi", "<cmd>Lazy install<cr>", "Install")
keymap("n", "<leader>ps", "<cmd>Lazy sync<cr>", "Sync")
keymap("n", "<leader>pu", "<cmd>Lazy update<cr>", "Update")
keymap("n", "<leader>pr", "<cmd>Lazy restore<cr>", "Restore")
keymap("n", "<leader>pl", "<cmd>Lazy<cr>", "Lazy")

-- Rest
keymap("n", "<leader>r", "", "Rest")
keymap("n", "<leader>rr", "<Plug>RestNvim", "Run rest")
keymap("n", "<leader>rp", "<Plug>RestNvimPreview", "Run rest preview")
keymap("n", "<leader>rl", "<Plug>RestNvimLast", "Run rest last")

-- Terminal
keymap("n", "<leader>t", "", "Terminal")
keymap("n", "<C-t>", "<cmd>ToggleTerm<cr>", "Toggle Term")
keymap("n", "<leader>t1", ":1ToggleTerm<cr>", "1")
keymap("n", "<leader>t2", ":2ToggleTerm<cr>", "2")
keymap("n", "<leader>t3", ":3ToggleTerm<cr>", "3")
keymap("n", "<leader>t4", ":4ToggleTerm<cr>", "4")
keymap("n", "<leader>f", "<cmd>ToggleTerm direction=float<cr>", "Float")
keymap("n", "<leader>h", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal")
keymap("n", "<leader>j", "<cmd>TermExec cmd='gjs %'<cr>", "Execute JavaScript")
keymap("n", "<leader>p", "<cmd>TermExec cmd='python %'<cr>", "Execute Python")
keymap("n", "<leader>t", "<cmd> ToggleTerm<cr>", "Open terminal")

-- Treesitter
keymap("n", "<leader>T", "", "Treesitter")
keymap("n", "<leader>Th", "<cmd>TSHighlightCapturesUnderCursor<cr>", "Highlight")
keymap("n", "<leader>Tp", "<cmd>TSPlaygroundToggle<cr>", "Playground")
keymap("n", "<leader>Tr", "<cmd>TSToggle rainbow<cr>", "Rainbow")

-- Treesitter
keymap("n", "<leader>u", "", "TodoComments")
keymap("n", "<leader>ut", "<cmd>TodoTelescope<CR>", "Show Comments")
keymap("n", "<leader>uq", "<cmd>TodoQuickFix<CR>", "Quick Fix")
keymap("n", "<leader>ul", "<cmd>TodoLocList<CR>", "List Comments")

--
keymap("n", "<leader>v", "<cmd>Outline<cr>", "Outline")

-- Window
keymap("n", "<leader>w", "", "Treesitter")
keymap("n", "<leader>wv", "<C-w>v", "Vertical Split")
keymap("n", "<leader>wh", "<C-w>s", "Horizontal Split")
keymap("n", "<leader>we", "<C-w>=", "Make Splits Equal")
keymap("n", "<leader>wq", "close<CR>", "Close Split")
keymap("n", "<leader>wm", "MaximizerToggle<CR>", "Toggle Maximizer")

-- Trouble
keymap("n", "<leader>x", "", "Trouble")
keymap("n", "<leader>xx", "<cmd>Trouble<cr>", "Open Trouble window")
keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", "Diagnostics")
keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", "Documents")
keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", "List")
keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", "QuickFix")


keymap("t", "<C-t>1", "<cmd>1ToggleTerm<cr>", "ToggleTerm")
keymap("t", "<C-t>2", "<cmd>2ToggleTerm<cr>", "ToggleTerm")
keymap("t", "<C-t>3", "<cmd>3ToggleTerm<cr>", "ToggleTerm")
keymap("t", "<C-t>4", "<cmd>4ToggleTerm<cr>", "ToggleTerm")
keymap("t", "<esc>", "<cmd>ToggleTerm<cr>", "ToggleTerm")
keymap("t", "<C-h>", "<cmd>wincmd h<cr>", "ToggleTerm")
keymap("t", "<C-j>", "<cmd>wincmd j<cr>", "ToggleTerm")
keymap("t", "<C-k>", "<cmd>wincmd k<cr>", "ToggleTerm")
keymap("t", "<C-l>", "<cmd>wincmd l<cr>", "ToggleTerm")
keymap("t", "<C-w>h", "<C-\\><C-n><C-w>h", "ToggleTerm")
keymap("t", "<C-w>j", "<C-\\><C-n><C-w>j", "ToggleTerm")
keymap("t", "<C-w>k", "<C-\\><C-n><C-w>k", "ToggleTerm")
keymap("t", "<C-w>l", "<C-\\><C-n><C-w>l", "ToggleTerm")
keymap("t", "<C-w><C-w>", "<C-\\><C-n><C-w><C-w>", "ToggleTerm")
