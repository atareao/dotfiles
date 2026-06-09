---@type vim.lsp.Config
return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yml" },
  init_options = {
    -- Enable schema support
    schemas = {
      ["http://json.schemastore.org/github-workflow"] = "*.github/workflows/*.yml",
      ["http://json.schemastore.org/github-action"] = "*.github/workflows/*.yaml",
    },
  },
}