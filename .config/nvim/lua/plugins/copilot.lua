return {
    --"github/copilot.vim"
    "zbirenbaum/copilot.lua",
    dependencies = {
        'AndreM222/copilot-lualine',
        --"zbirenbaum/copilot-cmp",
    },
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
        filetypes = {
            markdown = true,
        },
    },
    config = true,
    
}
