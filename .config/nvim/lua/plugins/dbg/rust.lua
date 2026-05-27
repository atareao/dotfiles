local dap = require "dap"

local codelldb_path = vim.fn.executable('codelldb') == 1 and 'codelldb'
    or vim.fn.stdpath('data') .. '/mason/bin/codelldb'

dap.adapters.lldb = {
  type = 'executable',
  command = codelldb_path,
  name = 'lldb',
}

local function get_rust_binary()
    local cargo_toml = vim.fn.findfile('Cargo.toml', vim.fn.getcwd() .. ';')
    if cargo_toml ~= '' then
        for line in io.lines(cargo_toml) do
            local name = line:match('^name%s*=%s*"([^"]+)"')
            if name then
                local profile = vim.fn.isdirectory(vim.fn.getcwd() .. '/target/release') == 1 and 'release' or 'debug'
                return vim.fn.getcwd() .. '/target/' .. profile .. '/' .. name
            end
        end
    end
    return vim.fn.getcwd() .. '/target/debug/'
end

dap.configurations.rust = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Binary: ', get_rust_binary(), 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = function()
            return vim.fn.input('Args: ')
        end,
        runInTerminal = true,
    },
    {
        name = 'Launch (quick)',
        type = 'lldb',
        request = 'launch',
        program = function()
            return get_rust_binary()
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = function()
            return vim.fn.input('Args: ')
        end,
        runInTerminal = true,
    },
}

dap.configurations.cpp = dap.configurations.rust
