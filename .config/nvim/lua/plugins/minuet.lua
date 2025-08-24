return {
    "milanglacier/minuet-ai.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "Saghen/blink.cmp"
    },
    opts = {
        cmp = {
            enable_auto_complete = false,
        },
        blink = {
            enable_auto_complete = true,
        },
        provider = "gemini",
        provider_options = {
            gemini = {
                model = 'gemini-2.5-flash',
                stream = true,
                optional = {},
            },
            claude = {
                model = "claude-3-5-haiku-20241022",
                stream = true,
            }
        }
    }

}
