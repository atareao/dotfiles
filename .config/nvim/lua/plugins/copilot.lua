return {
    --"github/copilot.vim"
    "zbirenbaum/copilot.lua",
    dependencies = {
        'AndreM222/copilot-lualine'
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
