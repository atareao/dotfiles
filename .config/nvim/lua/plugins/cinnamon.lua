return {
    'declancm/cinnamon.nvim',
    config = function()
        require('cinnamon').setup({
             extra_keymaps = true,
             override_keymaps = true,
             max_length = 500,
             scroll_limit = -1,
        })
    end
}
