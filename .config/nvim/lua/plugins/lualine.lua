local function window()
  return vim.api.nvim_win_get_number(0)
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
    dependencies = { 'nvim-tree/nvim-web-devicons' },
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
            lualine_a = { {window}, 'mode' },
            lualine_b = { {'b:gitsigns_head', icon = ''}, {'diff', source = diff_source},
                {
                    'diagnostics',
                    sources = { "nvim_diagnostic" },
                    symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' }
                }
            },
            lualine_c = { 'filename' },
            lualine_x = { 'copilot', 'encoding', 'fileformat', 'filetype' },
            lualine_y = { {getWords}, 'progress' },
            lualine_z = { 'location' }
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
        inacvtive_winbar = {},
        extensions = {}
    },
    config = true
}
