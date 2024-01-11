return {
    "Shatur/neovim-ayu",
    lazy = false,
    config = function()
        local opt = vim.opt
        opt.termguicolors = true      -- enable 24-bit RGB colors
        require('ayu').setup({
            mirage = false,
            overrides = {
                tkLink = {fg = "#39BAE6"},
                tkBrackets = {fg = "#FF8F40"},
                tkHighLight = {fg = "#ABB0B6"},
                tkTagSep = {fg = "#399E66"},
                tkTag = {fg = "#F27083"},
                Visual = {fg = "#000000", bg = "#FFC1D5"},
            },
        })
        require('ayu').colorscheme()
    end
}
