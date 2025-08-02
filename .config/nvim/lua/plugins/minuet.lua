return {
    {
        'milanglacier/minuet-ai.nvim',
        config = function()
            require('minuet').setup {
                -- Your configuration options here
                provider = 'gemini',
                provider_options = {
                    gemini = {
                        api_key = "GEMINI_API_KEY",
                        model = "gemini-2.5-flash-lite"
                    },
                },
                auto_trigger = {
                    enabled = true, -- true para autocompletado, false para solo manual
                    delay_ms = 500, -- Retraso antes de que Minuet intente completar
                },
            }
        end,
    },
    { 'nvim-lua/plenary.nvim' },
    -- optional, if you are using virtual-text frontend, nvim-cmp is not
    -- required.
    { 'hrsh7th/nvim-cmp' },
}
