---@type vim.lsp.Config
return {
  cmd = { "marksman", "server" },
  filetypes = { "markdown" },
  init_options = {
    -- Enable markdown linting
    linting = {
      enable = true,
    },
  },
}
