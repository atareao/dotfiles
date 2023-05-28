local rt = require("rust-tools")

rt.setup({
    autoSetHints = false,
    tools = {
        executor = require("rust-tools/executors").termopen,
        inlay_hints = {
            auto = true,
            only_current_line = false,
        }
    },
  hover_actions = {
      auto_focus = true
  },
  server = {
    standalone = true,
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})
