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
            ["react"] = {
                strategy = "chat",
                description = "Experto en React",
                prompts = {
                    {
                        role = "system",
                        content = "Eres un experimentado desarrollador de React enfocado en Typescript."
                    },
                    {
                        role = "user",
                        content = ""
                    }
                }
            },
            ["python"] = {
                strategy = "chat",
                description = "Experto en Python",
                prompts = {
                    {
                        role = "system",
                        content = "Eres un experimentado desarrollador de Python"
                    },
                    {
                        role = "user",
                        content = ""
                    }
                }
            },
            ["rust"] = {
                strategy = "chat",
                description = "Experto en Rust",
                prompts = {
                    {
                        role = "system",
                        content = "Eres un experimentado desarrollador de Rust"
                    },
                    {
                        role = "user",
                        content = ""
                    }
                }
            },
            ["linux"] = {
                strategy = "chat",
                description = "Experto en Linux",
                prompts = {
                    {
                        role = "system",
                        content = "Eres un administrador de sistemas Linux. Estás especializado en mantenimiento de sistemas y en scripting en cualquier shell",
                    },
                    {
                        role = "user",
                        content = ""
                    }
                }
            }
        }
    },
    config = true
}
