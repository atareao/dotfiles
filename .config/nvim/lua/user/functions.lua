local M = {}

function M.toggle_option(opt)
    vim.opt[opt]:toggle()
end

function M.toggle_tabline()
    if vim.opt.showtabline:get() == 0 then
        vim.opt.showtabline = 2
    else
        vim.opt.showtabline = 0
    end
end

return M