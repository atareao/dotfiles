local function clients_lsp()
    local clients = vim.lsp.get_clients()
    if next(clients) == nil then return "" end
    local c = {}
    for _, client in pairs(clients) do
        table.insert(c, client.name)
    end
    return " " .. table.concat(c, "|")
end

local function word_count()
    if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
        return vim.fn.wordcount().visual_words
    end
    return vim.fn.wordcount().words
end

local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "AndreM222/copilot-lualine",
        "smiteshp/nvim-navic",
    },
    opts = {
        options = {
            icons_enabled = true,
            theme = "ayu_dark",
            section_separators = { left = "", right = "" },
            component_separators = { left = "", right = "" },
            always_divide_middle = true,
        },
        sections = {
            lualine_a = {
                {
                    "mode",
                    separator = { left = "", right = "" },
                    icon = { "", align = "left" },
                    fmt = function(mode)
                        return mode:sub(1, 1) .. " #" .. vim.api.nvim_win_get_number(0)
                    end,
                },
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
                    "b:gitsigns_head",
                    icon = "",
                },
                {
                    "diff",
                    symbols = { added = " ", modified = " ", removed = " " },
                    colored = false,
                    source = diff_source,
                },
            },
            lualine_x = {
                "copilot",
                {
                    "encoding",
                    fmt = function(e)
                        return e ~= "utf-8" and e or ""
                    end,
                },
                {
                    "fileformat",
                    fmt = function(f)
                        return f ~= "unix" and f or ""
                    end,
                },
            },
            lualine_y = {
                { clients_lsp },
                { word_count },
                "progress",
            },
            lualine_z = {
                {
                    "location",
                    separator = { left = "", right = " " },
                    icon = "",
                },
            },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = { "filename" },
            lualine_c = {
                {
                    "b:gitsigns_head",
                    icon = "",
                },
            },
            lualine_x = {},
            lualine_y = { "location" },
            lualine_z = {},
        },
        tabline = {
            lualine_a = {
                {
                    "buffers",
                    show_filename_only = true,
                    hide_filename_extension = false,
                    mode = 2,
                    separator = { left = "", right = "" },
                },
            },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {
                { "tabs", mode = 0, separator = { left = "", right = "" } },
            },
        },
        winbar = {
            lualine_a = { { "navic", separator = { left = "", right = "" } } },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        inactive_winbar = {
            lualine_a = { { "navic" } },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        extensions = { "toggleterm", "trouble", "nvim-dap-ui" },
    },
    config = true,
}