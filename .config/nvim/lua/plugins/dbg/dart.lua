local dap = require("dap")
dap.adapters.dart = {
    type = "executable",
    command = "flutter",
    -- This command was introduced upstream in https://github.com/dart-lang/sdk/commit/b68ccc9a
    args = {"debug_adapter"}
}
dap.configurations.dart = {
    {
        name = "Launch Flutter Program",
        type = "dart",
        request = "launch",
        -- The nvim-dap plugin populates this variable with the filename of the current buffer
        program = "${file}",
        -- The nvim-dap plugin populates this variable with the editor's current working directory
        cwd = "${workspaceFolder}",
        -- This gets forwarded to the Flutter CLI tool, substitute `linux` for whatever device you wish to launch
        stopOnEntry = true,
        toolArgs = {"-d", "linux"}
    }
}

