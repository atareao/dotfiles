local dap = require("dap")

dap.adapters.node2 = {
    type = "server",
    port = "${port}",
    executable = {
        command = "node",
        args = { "--inspect-brk=127.0.0.1:${port}", "${file}" },
    },
}

dap.configurations.typescript = {
    {
        type = "node2",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
        },
        skipFiles = { "<node_internals>/**" },
        stopOnEntry = true,
    },
    {
        type = "node2",
        request = "launch",
        name = "Launch with tsx",
        runtimeExecutable = "npx",
        runtimeArgs = { "tsx" },
        program = "${file}",
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        skipFiles = { "<node_internals>/**" },
        stopOnEntry = true,
    },
    {
        type = "node2",
        request = "attach",
        name = "Attach to process",
        port = 9229,
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
        },
        skipFiles = { "<node_internals>/**" },
    },
}

dap.configurations.javascript = dap.configurations.typescript
dap.configurations.typescriptreact = dap.configurations.typescript
dap.configurations.javascriptreact = dap.configurations.typescript