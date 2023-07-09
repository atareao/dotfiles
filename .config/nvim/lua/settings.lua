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
--cmd [[autocmd FileType markdown let g:indentLine_enabled=0]]

au(
    "BufEnter",
    {
        pattern = "markdown",
        callback = function()
            vim.g.indentLine_enabled = 0
        end
    }
)

-----------------------------------------------------------
-- Highlight
-----------------------------------------------------------
-- highlight yanked text
au(
    "TextYankPost",
    {
        pattern = '*',
        callback = function()
            vim.highlight.on_yank { higroup='IncSearch', timeout=700 }
        end,
        group = ag('yank_highlight', {}),
    }
)
-----------------------------------------------------------
-- Spell
-----------------------------------------------------------
-- enable spanish spell on markdown only
local markdown_spell = ag("markdownSpell", {})
au(
    "FileType",
    {
        pattern = "markdown",
        callback = function()
            vim.opt.spelllang = "es"
            vim.opt.spell = true
        end,
        group = markdown_spell
    }
)
au(
    {"BufRead", "BufNewFile"},
    {
        pattern = "*.md",
        callback = function()
            vim.opt.spelllang = "es"
            vim.opt.spell = true
        end,
        group = markdown_spell
    }
)
-----------------------------------------------------------
-- Templates
-----------------------------------------------------------
-- enable templates
au(
    "BufNewFile",
    {
        pattern = "*",
        callback = function()
            vim.g.template_name = "Lorenzo Carbonell <a.k.a. atareao>"
            local extension = vim.fn.expand("%:e")
            local template = vim.env.HOME .. "/.config/nvim/templates/" .. extension .. ".tpl"
            local f = io.open(template, "r")
            if f ~= nil then
                local lines = {}
                for line in io.lines(template) do
                    lines[#lines + 1] = line
                end
                api.nvim_buf_set_lines(0, 0, 0, false, lines)
                cmd([[%s/{{YEAR}}/\=strftime('%Y')/ge]])
                cmd([[%s/{{NAME}}/\=template_name/ge]])
                cmd([[%s/{{EVAL\s*\([^}]*\)}}/\=eval(submatch(1))/ge]])
                cmd([[%s/{{FILENAME}}/\=expand('%:t')/ge]])
            end
        end,
        group = ag("templates", {})
    }
)

-----------------------------------------------------------
-- Folds
-----------------------------------------------------------
-- open files with opened folds
au(
    "BufWinEnter",
    {
        pattern = "*",
        callback = function()
            cmd([[normal zR]])
        end
    }
)
