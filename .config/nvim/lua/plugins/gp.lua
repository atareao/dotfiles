return {
    "robitx/gp.nvim",
    opts = {
        providers = {
            openai = {
                disable = true,
            },
            copilot = {
                disable = false,
            },
            anthropic = {
                disable = false,
            }
        },
        default_command_agent = "copilot",
        default_chat_agent = "ChatClaude-3-5-Sonnet",

    },
    config = true,
}
