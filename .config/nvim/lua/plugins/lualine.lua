local function window()
    return vim.api.nvim_win_get_number(0)
end

local clients_lsp = function()
    local clients = vim.lsp.get_clients()
    if next(clients) == nil then
        return ""
    end

    local c = {}
    for _, client in pairs(clients) do
        table.insert(c, client.name)
    end
    return " " .. table.concat(c, "|")
end

local function getWords()
    if vim.fn.mode() == "v" or vim.fn.mode() == "V" or vim.fn.mode() == "" then
        return vim.fn.wordcount().visual_words
    else
        return vim.fn.wordcount().words
    end
end

local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed
        }
    end
end
return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'AndreM222/copilot-lualine',
    },
    opts = {
        options = {
            icons_enabled = true,
            theme = 'ayu_dark',
            section_separators = { left = '', right = '' },
            component_separators = { left = '', right = '' },
            disabled_filetypes = {},
            always_divide_middle = true
        },
        sections = {
            lualine_a = {
                { window },
                { 'mode', separator = { left = " ", right = "" }, icon = "" },
            },
            lualine_b = {
                {
                    "filetype",
                    icon_only = true,
                    padding = { left = 1, right = 0 },
                },
                "filename",
            },
            lualine_c = {
                {
                    'b:gitsigns_head',
                    icon = ''
                },
                {
                    'diff',
                    symbols = { added = " ", modified = " ", removed = " " },
                    colored = false,
                    source = diff_source
                },
                {
                    'diagnostics',
                    sources = { "nvim_diagnostic" },
                    symbols = { error = " ", warn = " ", info = " ", hint = " " },
                    update_in_insert = true,
                }
            },
            lualine_x = {
                'copilot',
                'encoding',
                'fileformat',
            },
            lualine_y = {
                { clients_lsp },
                { getWords },
                'progress'
            },
            lualine_z = {
                { 'location', separator = { left = "", right = " " }, icon = "" }
            },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = { "toggleterm", "trouble" }
    },
    config = true
}
