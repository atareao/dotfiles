return {
    "HiPhish/rainbow-delimiters.nvim",
     event = "VeryLazy",
    config = function()
        local rainbow_delimiters = require('rainbow-delimiters')
        require('rainbow-delimiters.setup')({
            strategy = {
                [''] = rainbow_delimiters.strategy['global'],
                commonlisp = rainbow_delimiters.strategy['local'],
            },
            query = {
                [''] = 'rainbow-delimiters',
                latex = 'rainbow-blocks',
            },
            highlight = {
                'RainbowDelimiterRed',
                'RainbowDelimiterYellow',
                'RainbowDelimiterBlue',
                'RainbowDelimiterOrange',
                'RainbowDelimiterGreen',
                'RainbowDelimiterViolet',
                'RainbowDelimiterCyan',
            },
            blacklist = {'c', 'cpp'},
        })
    end,
}

