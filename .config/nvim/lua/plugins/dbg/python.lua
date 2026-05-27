local dap = require("dap")

require("dap-python").setup("python3")

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
        args = {},
    },
    {
        type = "python",
        request = "launch",
        name = "Launch file (no stop)",
        program = "${file}",
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
    },
    {
        type = "python",
        request = "launch",
        name = "Launch with args",
        program = "${file}",
        args = function()
            local args = vim.fn.input('Args: ')
            return vim.split(args, " ")
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
    },
}
