return {
    'gen740/SmoothCursor.nvim',
    event = "VeryLazy",
    config = function()
        require('smoothcursor').setup({
            type = "exp",
            fancy ={
                enable = true
            }

        })
    end
}
