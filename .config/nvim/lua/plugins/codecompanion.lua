return {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    opts = {
        log_level = "DEBUG",
        interactions = {
            cmd = {
                adapter = {
                    name = "ollama",
                    model = "myaniu/qwen2.5-1m:7b"
                }
            },
            chat = {
                adapter = {
                    name = "ollama",
                    model = "myaniu/qwen2.5-1m:7b"
                }
            },
            inline = {
                adapter = {
                    name = "ollama",
                    model = "myaniu/qwen2.5-1m:7b"
                }
            }
        }
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
}
