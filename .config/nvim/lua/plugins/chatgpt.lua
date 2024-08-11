return {
  "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim"
    },
    opts = {
        model = "gpt-4o-mini",
        api_key_cmd = "gopass show -o openai/token",
        actions_paths = "~/.config/nvim/custom_actions.json",
        predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/atareao/prompts-para-chatgpt/main/prompts.csv",
    },
    config = true
}
