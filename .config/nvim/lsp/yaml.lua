-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/yamlls.lua
return {
    cmd = {
        "yaml-language-server",
        "--stdio",
    },
    filetypes = {
        "yaml",
        "yaml.docker-compose",
        "yaml.gitlab",
    },
    root_markers = {
        ".git",
    },
    settings = {
        -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
        redhat = { telemetry = { enabled = false } },
    },

    single_file_support = true,
}
