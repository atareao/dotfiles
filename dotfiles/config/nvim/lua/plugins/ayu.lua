local cmd = vim.cmd
local opt = vim.opt

opt.termguicolors = true      -- enable 24-bit RGB colors
cmd [[colorscheme ayu]]
require('ayu').setup({
    mirage = false,
    overrides = {},
})
