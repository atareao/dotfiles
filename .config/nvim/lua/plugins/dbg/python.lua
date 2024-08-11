local dap = require("dap")
dap.adapters.python = {
    type = "executable",
    command = vim.fn.getcwd() .. '/bin/python',
    args = { "-m", "debugpy.adapter"},
}
dap.configurations.python = {
    {
        name = "Launch",
        type = "python",
        request = "launch",
        program = "${file}",
        -- program = function()
        --     return vim.fn.input('Ruta al main: ', vim.fn.getcwd() .. '/src/', 'file')
        -- end,
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
        args = {},
    }
}
