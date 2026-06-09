return {
    "lervag/wiki.vim",
    priority = 1000,
    config = function()
        vim.g.wiki_root = "/data/notas"
        vim.g.wiki_filetypes = { "md" }
        vim.g.wiki_link_extension = ".md"
        vim.g.wiki_select_method = {
            pages = require("wiki.ui_select").pages,
            tags = require("wiki.ui_select").tags,
            toc = require("wiki.ui_select").toc,
            links = require("wiki.ui_select").links,
        }
    end,
}