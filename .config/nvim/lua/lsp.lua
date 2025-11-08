local lsp_path = vim.fn.expand('~/.config/nvim/lsp')
local lsp_files = {}

local handle = vim.uv.fs_opendir(lsp_path)
if handle then
    while true do
        local stat = vim.uv.fs_readdir(handle)
        if not stat then
            break
        end
        vim.notify("file: " .. stat[1].name, vim.log.levels.INFO, { title = "LSP Files" })
        -- Si es un archivo, lo procesamos
        if stat[1].type == 'file' then
            local filename = stat[1].name
            -- Comprobamos si el archivo tiene extensión .lua
            if filename:match('%.lua$') then
                -- Quitamos la extensión del archivo y lo añadimos a la tabla
                filename = filename:gsub('%.lua$', '')
                table.insert(lsp_files, filename)
            end
        end
    end
    vim.uv.fs_closedir(handle)
end

-- Mostramos la lista final de archivos sin la extensión.
local final_list = vim.inspect(lsp_files)
vim.notify(final_list, vim.log.levels.INFO, { title = "LSP Files" })
-- First enable the LSPs
vim.lsp.enable(lsp_files)
vim.lsp.inlay_hint.enable(true)

-- Initial diagnostic config (virtual_text on, virtual_lines off)
vim.diagnostic.config({
    virtual_text = false,
    -- virtual_lines = false,
    underline = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
    update_in_insert = false,
    severity_sort = true,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "javascript",
        "javascriptreact",
        "javascript.jsx",
    },
    callback = function(args)
        local buf = args.buf
        local bufname = vim.api.nvim_buf_get_name(buf)

        -- Check for Node/TS
        local node_root = vim.fs.find({ "tsconfig.json", "jsconfig.json" }, { upward = true, path = bufname })[1]
        if node_root then
            vim.lsp.enable("ts", { bufnr = buf })
            return
        end
    end,
})
