return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        -- The following are optional:
        "nvim-telescope/telescope.nvim", -- For using slash commands
        { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
    },
    opts = {
        language = "Spanish",
        display = {
            chat = {
                render_headers = false,
            }
        },
        prompt_library = {
            ["ejemplo"] = {
                strategy = "chat",
                description = "Ejemplo de chat",
                prompts = {
                    {
                        role = "system",
                        content = "Eres un experimentado desarrollador de Rust"
                    },
                    {
                        role = "user",
                        content = "Puedes explicarme porque ..."
                    }
                }
            }
        }
    },
    config = true
}
