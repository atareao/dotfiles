-----------------------------------------------------------
-- Neovim settings
-----------------------------------------------------------

-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
--local map = vim.api.nvim_set_keymap  -- set global keymap
local cmd = vim.cmd                    -- execute Vim commands
local exec = vim.api.nvim_exec         -- execute Vimscript
local fn = vim.fn                      -- call Vim functions
local g = vim.g                        -- global variables
local opt = vim.opt                    -- global/buffer/windows-scoped options
local api = vim.api                    -- call Vim api
local ag = vim.api.nvim_create_augroup -- create autogroup
local au = vim.api.nvim_create_autocmd -- create autocomand


-----------------------------------------------------------
-- General
-----------------------------------------------------------
g.mapleader = ';'             -- change leader to a comma
opt.mouse = 'a'               -- enable mouse support
opt.clipboard = 'unnamedplus' -- copy/paste to system clipboard
opt.swapfile = false          -- don't use swapfile

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true             -- show line number
opt.relativenumber = true     -- show line number
opt.showmatch = true          -- highlight matching parenthesis
opt.foldmethod = 'expr'       -- enable folding (default 'foldmarker')
opt.colorcolumn = '80'        -- line lenght marker at 80 columns
opt.splitright = true         -- vertical split to the right
opt.splitbelow = true         -- orizontal split to the bottom
opt.ignorecase = true         -- ignore case letters when search
opt.smartcase = true          -- ignore lowercase for the whole pattern
opt.linebreak = true          -- wrap on word boundary
opt.conceallevel = 0
opt.termguicolors = true
opt.guifont = "JetBrainsMono Nerd Font"
g.neovide_cursor_vfx_mode = "railgun"

-----------------------------------------------------------
-- Folding
-----------------------------------------------------------
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'



opt.list = true
opt.listchars = 'tab:▸ ,space:·,nbsp:␣,trail:•,precedes:«,extends:»'

-----------------------------------------------------------
-- Helper function
-----------------------------------------------------------

-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
local M = {}
function M.nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        api.nvim_command('augroup '..group_name)
        api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            api.nvim_command(command)
        end
        api.nvim_command('augroup END')
    end
end

local autoCommands = {
    -- other autocommands
    markdown_spell = {
        {"FileType", "markdown", "setlocal", "spell", "spelllang=es"},
        {"BufRead,BufNewFile", "*.md", "setlocal", "spell", "spelllang=es"},
    },
    open_folds = {
        {"BufReadPost,FileReadPost", "*", "normal zR"}
    },
    yank_highlight = {
        {"TextYankPost", "*", "silent!", "lua", "vim.highlight.on_yank{higroup='IncSearch', timeout=700}"}
    },
}

M.nvim_create_augroups(autoCommands)

-- set spell
-- exec ([[
--   setlocal spell spelllang=es
--   set spell
--   ]], false)
-- exec ([[
--     augroup markdownSpell
--         autocmd!
--         autocmd FileType markdown setlocal spell spelllang=es
--         autocmd BufRead,BufNewFile *.md setlocal spell spelllang=es
--     augroup END
--   ]], false)

-- remove whitespace on save
-- cmd [[au BufWritePre * :%s/\s\+$//e]]

-- highlight on yank
--exec([[
--  augroup YankHighlight
--    autocmd!
--    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
--  augroup end
--]], false)

-- templates
exec([[
  augroup templates
      au!
      let g:template_name = 'Lorenzo Carbonell <a.k.a. atareao>'
      autocmd BufNewFile *.* silent! execute '0r $HOME/.config/nvim/templates/'.expand("<afile>:e").'.tpl'
      autocmd BufNewFile * %s/{{YEAR}}/\=strftime('%Y')/ge
      autocmd BufNewFile * %s/{{NAME}}/\=template_name/ge
      autocmd BufNewFile * %s/{{EVAL\s*\([^}]*\)}}/\=eval(submatch(1))/ge
      autocmd BufNewFile * %s/{{FILENAME}}/\=expand('%:t')/ge
  augroup END
]], false)

-- autoexec
exec([[
  augroup execute
    autocmd FileType javascript map <buffer> <F5> :w<CR>:exec '!gjs' shellescape(@%, 1)<CR>
    autocmd FileType javascript imap <buffer> <F5> <esc>:w<CR>:exec '!gjs' shellescape(@%, 1)<CR>
    autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
    autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!python' shellescape(@%, 1)<CR>
  augroup END
]],false)

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true         -- enable background buffers
opt.history = 100         -- remember n lines in history
-- opt.lazyredraw = true     -- faster scrolling
opt.synmaxcol = 1000      -- max column for syntax highlight

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true      -- use spaces instead of tabs
opt.shiftwidth = 4        -- shift 4 spaces when tab
opt.tabstop = 4           -- 1 tab == 4 spaces
opt.smartindent = true    -- autoindent new lines

-- don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- remove line lenght marker for selected filetypes
cmd [[autocmd FileType text,markdown,xml,html,xhtml,javascript setlocal cc=0]]

-- 2 spaces for selected filetypes
-- cmd [[
--   autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2
-- ]]

-- IndentLine
--g.indentLine_setColors = 0  -- set indentLine color
g.indentLine_char = '|'       -- set indentLine character

-- disable IndentLine for markdown files (avoid concealing)
cmd [[autocmd FileType markdown let g:indentLine_enabled=0]]

-----------------------------------------------------------
-- Terminal
-----------------------------------------------------------
-- open a terminal pane on the right using :Term
cmd [[command Term :botright vsplit term://$SHELL]]

-- Terminal visual tweaks
--- enter insert mode when switching to terminal
--- close terminal buffer on process exit
cmd [[
    autocmd TermOpen * setlocal listchars= nonumber norelativenumber nocursorline
    autocmd TermOpen * startinsert
    autocmd BufLeave term://* stopinsert
]]

cmd [[
    autocmd BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path "%"
]]

-----------------------------------------------------------
-- Highlight
-----------------------------------------------------------
-- highlight yanked text
-- au('TextYankPost', {
--   group = ag('yank_highlight', {}),
--   pattern = '*',
--   callback = function()
--     vim.highlight.on_yank { higroup='IncSearch', timeout=700 }
--   end,
-- })

--  augroup YankHighlight
--    autocmd!
--    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
--  augroup end
