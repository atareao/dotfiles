---@type vim.lsp.Config
return {
  cmd = { "marksman", "--stdio" },
  filetypes = { "markdown" },
  init_options = {
    -- Enable markdown linting
    linting = {
      enable = true,
    },
  },
}