-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/ansiblels.lua
return {
    cmd = {
        "ansible-language-server",
        "--stdio",
    },
    filetypes = {
        "yaml.ansible",
    },
    root_markers = {
        ".ansible-lint",
        "ansible.cfg",
    },
    settings = {
        ansible = {
            python = {
                interpreterPath = "python",
            },
            ansible = {
                path = "ansible",
            },
            executionEnvironment = {
                enabled = false,
            },
            validation = {
                enabled = true,
                lint = {
                    enabled = true,
                    path = "ansible-lint",
                },
            },
        },
    },

    single_file_support = true,
}
