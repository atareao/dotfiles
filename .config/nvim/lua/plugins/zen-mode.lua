return -- Lua
{
    "folke/zen-mode.nvim",
    opts = {
        window = {
            backdrop = 0.5,
            width = 80,
        },
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        kitty = {
            enabled = true,
        },
        plugins = {
            twilight = { enabled = true },
        }
    },
    config = true,
}
