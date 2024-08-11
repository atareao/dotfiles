local dap = require "dap"
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb', -- adjust as needed, must be absolute path
  name = 'lldb'
}
dap.adapters.rust = {
    type = 'executable',
    attach = {
        pidProperty = "pid",
        pidSelect = "ask"
    },
    command = '/usr/bin/rust-lldb', -- my binary was called 'lldb-vscode-11'
    env = {
        LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
    },
    name = "lldb"
}
dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = "${file}",
    -- program = function()
    --   return vim.fn.input('Ruta al ejecutable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
    -- end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {
            function()
                return vim.fn.input('Params: ')
            end,
        }

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
}
dap.configurations.rust = dap.configurations.cpp

