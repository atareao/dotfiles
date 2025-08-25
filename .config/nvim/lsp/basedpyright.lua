local function organize_imports()
    local params = {
        command = 'basedpyright.organizeimports',
        arguments = { vim.uri_from_bufnr(0) },
    }

    local clients = vim.lsp.get_clients {
        bufnr = vim.api.nvim_get_current_buf(),
        name = 'basedpyright',
    }
    for _, client in ipairs(clients) do
        client.request('workspace/executeCommand', params, nil, 0)
    end
end

local function set_python_path(path)
    local clients = vim.lsp.get_clients {
        bufnr = vim.api.nvim_get_current_buf(),
        name = 'basedpyright',
    }
    for _, client in ipairs(clients) do
        if client.settings then
            client.settings.python = vim.tbl_deep_extend('force', client.settings.python or {}, { pythonPath = path })
        else
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings,
                { python = { pythonPath = path } })
        end
        client.notify('workspace/didChangeConfiguration', { settings = nil })
    end
end
return {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
    },
    settings = {
        basedpyright = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                ignorePatterns = { "*.pyi" },
                diagnosticSeverityOverrides = {
                    reportCallIssue = "warning",
                    reportUnreachable = "warning",
                    reportUnusedImport = "none",
                    reportUnusedCoroutine = "warning",
                },
                -- diagnosticMode = "workspace",
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "basic",
                reportCallIssue = "none",
                disableOrganizeImports = true,
            },
        },
    },
    commands = {
        PyrightOrganizeImports = {
            organize_imports,
            description = 'Organize Imports',
        },
        PyrightSetPythonPath = {
            set_python_path,
            description = 'Reconfigure basedpyright with the provided python path',
            nargs = 1,
            complete = 'file',
        },
    },
}
