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
}
