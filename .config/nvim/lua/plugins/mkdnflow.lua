return {
    "jakewvincent/mkdnflow.nvim",
    event = "VeryLazy",
    config = function()
        require('mkdnflow').setup({
            filetypes = {md = true, rmd = true, markdown = true},
            create_dirs = true,
            perspective = {
                priority = 'root',
                fallback = 'current',
                root_tell = '.git',
                nvim_wd_heel = true
            },
            wrap = false,
            bib = {
                default_path = nil,
                find_in_root = true
            },
            silent = false,
            links = {
                style = 'wiki',
                conceal = false,
                implicit_extension = 'md',
                transform_implicit = false,
                transform_explicit = function(text)
                    text = text:gsub(" ", "-")
                    text = text:lower()
                    return(text)
                end
            },
            to_do = {
                symbols = {' ', '-', 'X'},
                update_parents = true,
                not_started = ' ',
                in_progress = '-',
                complete = 'X'
            },
            tables = {
                trim_whitespace = true,
                format_on_move = true
            },
            use_mappings_table = true,
            mappings = {
                MkdnNextLink = {'n', '<Tab>'},
                MkdnPrevLink = {'n', '<S-Tab>'},
                MkdnNextHeading = {'n', '<leader>]'},
                MkdnPrevHeading = {'n', '<leader>['},
                MkdnGoBack = {'n', '<BS>'},
                MkdnGoForward = {'n', '<Del>'},
                MkdnFollowLink = {{'n', 'v'}, '<CR>'},
                MkdnDestroyLink = {'n', '<M-CR>'},
                MkdnMoveSource = {'n', '<F2>'},
                MkdnYankAnchorLink = {'n', 'ya'},
                MkdnYankFileAnchorLink = {'n', 'yfa'},
                MkdnIncreaseHeading = {'n', '+'},
                MkdnDecreaseHeading = {'n', '-'},
                MkdnToggleToDo = {{'n', 'v'}, '<C-Space>'},
                MkdnNewListItem = false,
                MkdnExtendList = false,
                MkdnUpdateNumbering = {'n', '<leader>nn'},
                MkdnTableNextCell = {'i', '<Tab>'},
                MkdnTablePrevCell = {'i', '<S-Tab>'},
                MkdnTableNextRow = false,
                MkdnTablePrevRow = {'i', '<M-CR>'},
                MkdnTableNewRowBelow = {{'n', 'i'}, '<leader>ir'},
                MkdnTableNewRowAbove = {{'n', 'i'}, '<leader>iR'},
                MkdnTableNewColAfter = {{'n', 'i'}, '<leader>ic'},
                MkdnTableNewColBefore = {{'n', 'i'}, '<leader>iC'},
                MkdnCR = false,
                MkdnTab = false,
                MkdnSTab = false
            }
        })
    end,
}
