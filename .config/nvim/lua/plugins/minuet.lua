return {
    'milanglacier/minuet-ai.nvim',
    dependencies = {
        'Saghen/blink.cmp'
    },
    config = function()
        require('minuet').setup {
            provider = 'openai_fim_compatible',
            n_completions = 1, -- recommend for local model for resource saving
            -- I recommend beginning with a small context window size and incrementally
            -- expanding it, depending on your local computing power. A context window
            -- of 512, serves as an good starting point to estimate your computing
            -- power. Once you have a reliable estimate of your local computing power,
            -- you should adjust the context window to a larger value.
            context_window = 512,
            provider_options = {
                openai_fim_compatible = {
                    -- For Windows users, TERM may not be present in environment variables.
                    -- Consider using APPDATA instead.
                    api_key = 'TERM',
                    name = 'Ollama',
                    end_point = 'http://localhost:11434/v1/completions',
                    model = "myaniu/qwen2.5-1m:7b",
                    optional = {
                        max_tokens = 56,
                        top_p = 0.9,
                    },
                },
            },
        }
    end
}
