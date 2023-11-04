return {
    'declancm/cinnamon.nvim',
    event = "VeryLazy",
    config = function()
        require('cinnamon').setup({
            extra_keymaps = true,
            extended_keymaps = true, -- Create extended keymaps.
            override_keymaps = true,
            always_scroll = true,
            max_length = 500,
            scroll_limit = -1,
        })
    end
}
