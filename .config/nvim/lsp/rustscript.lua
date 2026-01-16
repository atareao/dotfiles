return {
    name = 'rust-analyzer-stscript',
    cmd = { 'rust-analyzer' },
    filetypes = { 'rustscript' },
    -- Forzamos que la raíz sea siempre el directorio del script
    root_dir = function(fname)
         return vim.fs.dirname(fname)
    end,
    settings = {
        ['rust-analyzer'] = {
            -- Soporte para archivos fuera de un workspace
            standalone_file_support = true,
            -- Esto le dice a RA: "No busques más, este archivo es su propio proyecto"
            linkedProjects = {},
            cargo = {
                autoreload = false,
            },
            diagnostics = {
                enable = true,
                disabled = { 'unlinked-file' },
            },
        },
    },
    single_file_support = true,
}
