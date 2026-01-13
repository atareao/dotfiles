local status_ok, util = pcall(require, "lspconfig.util")
if not status_ok then
    return {}
end

return {
    cmd = { 'rscls' },
    filetypes = { 'rustscript' },
    -- Define el root_dir de forma que no falle si no hay Cargo.toml
    root_dir = function(fname)
        local util = require('lspconfig.util')
        return util.root_pattern("Cargo.toml")(fname) or util.path.dirname(fname)
    end,
    settings = {
        ['rust-analyzer'] = {
            imports = {
                group = {
                    enable = true,
                },
                granularity = {
                    enforce = true,
                    group = "crate",
                },
            },
            linkedProjects = {},
            cargo = {
                buildOutDir = true,
                buildScripts = {
                    enable = true,
                },
            },
            checkOnSave = {
                enable = true,
            },
            procMacro = {
                enable = true,
            },
        },
    },
    single_file_support = true,
}
