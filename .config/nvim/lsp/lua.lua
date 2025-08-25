---@type vim.lsp.Config
return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc" },
    telemetry = { enabled = false },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
        },
    },
}
