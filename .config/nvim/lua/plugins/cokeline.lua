return {
    "willothy/nvim-cokeline",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons",
    },
    config = function()
        local get_hex = require('cokeline.hlgroups').get_hl_attr
        local mappings = require('cokeline.mappings')

        local comments_fg = get_hex('Comment', 'fg')
        local errors_fg = get_hex('DiagnosticError', 'fg')
        local warnings_fg = get_hex('DiagnosticWarn', 'fg')

        local red = vim.g.terminal_color_1
        local yellow = vim.g.terminal_color_3

        local abg = get_hex("Normal", 'bg')

        local nbg = "#6E665A"
        local sbg = "#D8A657"

        local components = {
            space = {
                text = ' ',
                truncation = { priority = 1 },
            },

            two_spaces = {
                text = '  ',
                truncation = { priority = 1 },
            },

            separator = {
                text = ' ',
                truncation = { priority = 1 },
                fg = abg,
                bg = abg,
            },

            devicon = {
                text = function(buffer)
                    return
                        (mappings.is_picking_focus() or mappings.is_picking_close())
                        and buffer.pick_letter .. ' '
                        or buffer.devicon.icon
                end,
                fg = function(buffer)
                    return
                        (mappings.is_picking_focus() and yellow)
                        or (mappings.is_picking_close() and red)
                        or buffer.devicon.color
                end,
                style = function(_)
                    return
                        (mappings.is_picking_focus() or mappings.is_picking_close())
                        and 'italic,bold'
                        or nil
                end,
                truncation = { priority = 1 }
            },

            index = {
                text = function(buffer)
                    return buffer.index .. ': '
                end,
                fg = function(buffer)
                    return buffer.is_focused and nbg or "#FFFFFF"
                end,
                truncation = { priority = 1 }
            },

            unique_prefix = {
                text = function(buffer)
                    return buffer.unique_prefix
                end,
                fg = function(buffer)
                    return buffer.is_focused and nbg or "#FFFFFF"
                end,
                style = 'italic',
                truncation = {
                    priority = 3,
                    direction = 'left',
                },
            },

            filename = {
                text = function(buffer)
                    return buffer.filename
                end,
                style = function(buffer)
                    return
                        ((buffer.is_focused and buffer.diagnostics.errors ~= 0)
                        and 'bold,underline')
                        or (buffer.is_focused and 'bold')
                        or (buffer.diagnostics.errors ~= 0 and 'underline')
                        or nil
                end,
                fg = function(buffer)
                    return buffer.is_focused and nbg or "#FFFFFF"
                end,
                truncation = {
                    priority = 2,
                    direction = 'left',
                },
            },

            diagnostics = {
                text = function(buffer)
                    return
                        (buffer.diagnostics.errors ~= 0 and ' ☢️ ' .. buffer.diagnostics.errors)
                        or (buffer.diagnostics.warnings ~= 0 and ' ⚠️ ' .. buffer.diagnostics.warnings)
                        or ''
                end,
                fg = function(buffer)
                    return
                        (buffer.diagnostics.errors ~= 0 and errors_fg)
                        or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
                        or nil
                end,
                truncation = { priority = 1 },
            },

            close_or_unsaved = {
                text = function(buffer)
                    return buffer.is_modified and '⏳' or '🔒'
                end,
                fg = function(buffer)
                    return buffer.is_focused and nbg or "#FFFFFF"
                end,
                delete_buffer_on_left_click = true,
                truncation = { priority = 1 },
            },
            left_half_circle = {
                text = "",
                fg = function(buffer)
                    return buffer.is_focused and sbg or nbg
                end,
                bg = abg,
                truncation = {priority = 1},
            },
            right_half_circle = {
                text = "",
                fg = function(buffer)
                    return buffer.is_focused and sbg or nbg
                end,
                bg = abg,
                truncation = {priority = 1},
            }
        }

        require('cokeline').setup({
            show_if_buffers_are_at_least = 2,

            buffers = {
                -- filter_valid = function(buffer) return buffer.type ~= 'terminal' end,
                -- filter_visible = function(buffer) return buffer.type ~= 'terminal' end,
                new_buffers_position = 'next',
            },

            rendering = {
                max_buffer_width = 30,
            },

            default_hl = {
                fg = function(buffer)
                    return
                        buffer.is_focused
                        and get_hex('Normal', 'fg')
                        or get_hex('Comment', 'fg')
                end,
                --bg = get_hex('ColorColumn', 'bg'),
                bg = function(buffer)
                    return
                        buffer.is_focused
                        and sbg
                        or nbg
                end,
            },
            sidebar = {
                filetype = 'neo-tree',
                components = {
                    {
                        text = function(buffer)
                            return " " .. buffer.filetype .. " "
                        end,
                        fg = vim.g.terminal_color_3,
                        bg = function()
                            return get_hex("NvimTreeNormal", "bg")
                        end,
                        bold = true,
                    },
                }
            },

            components = {
                components.separator,
                components.left_half_circle,
                components.space,
                components.devicon,
                components.space,
                components.index,
                components.unique_prefix,
                components.filename,
                components.diagnostics,
                components.two_spaces,
                components.close_or_unsaved,
                components.right_half_circle,
                components.separator,
            },
        })
    end
}
