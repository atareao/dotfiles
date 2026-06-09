---@type vim.lsp.Config
return {
  cmd = { "json-lsp" },
  filetypes = { "json" },
  init_options = {
    -- Enable schema support
    validation = {
      enable = true,
    },
  },
}