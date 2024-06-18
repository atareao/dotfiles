return {
    "nomnivore/ollama.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    -- All the user commands added by the plugin
    cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },

    keys = {
        -- Sample keybind for prompt menu. Note that the <c-u> is important for selections to work properly.
        {
            "<leader>oo",
            ":<c-u>lua require('ollama').prompt()<cr>",
            desc = "ollama prompt",
            mode = { "n", "v" },
        },

        -- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
        {
            "<leader>oG",
            ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
            desc = "ollama Generate Code",
            mode = { "n", "v" },
        },
    },

    ---@type Ollama.Config
    opts = {
        model = "codellama:13b-code-q6_K",
        url = "http://localhost:11434",
        serve = {
            on_start = false,
            command = "ollama",
            args = { "serve" },
            stop_command = "pkill",
            stop_args = { "-SIGTERM", "ollama" },
        },
        -- View the actual default prompts in ./lua/ollama/prompts.lua
        prompts = {
            DocString = {
                prompt = "Documenta con Docstring y de la forma mas específica que puedas la siguiente función Python:\n```$sel```\nNo me expliques como hay que documentar, simplemente Documenta. Ni me digas 'aquí tienes el resultado', ni nada por el estilo, simplemente Documenta. Por favor, sigue estricamente las convenciones de documentación 'PEP 257 Docstring Conventions'",
                model = "llama3:latest",
                action = "display_insert"
            },
            Sample_Prompt = {
                prompt = "This is a sample prompt that receives $input and $sel(ection), among others.",
                input_label = "> ",
                model = "codellama:13b-code-q6_K",
                action = "display",
            },
        }
    }
}
