return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = {
        heading = {
            enabled = true,
            icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
            position = 'overlay',
            signs = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
        },
        code = {
            enabled = true,
            sign = true,
            width = 'block',
            left_pad = 1,
            right_pad = 1,
        },
        checkbox = {
            enabled = true,
            icons = {
                unchecked = ' ',
                checked = ' ',
                pending = '󰥔 ',
            },
        },
        bullet = {
            enabled = true,
            icons = { '●', '○', '◆', '◇' },
        },
        pipe_table = {
            preset = 'round',
        },
        link = {
            enabled = true,
            highlight = 'RenderMarkdownLink',
        },
        dash = {
            enabled = true,
            icon = '─',
        },
    },
}
