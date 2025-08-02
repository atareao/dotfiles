return {
    "lervag/wiki.vim",
    opt = {
    },
    config = function()
        vim.g.wiki_select_method = {
      pages = require("wiki.ui_select").pages,
      tags = require("wiki.ui_select").tags,
      toc = require("wiki.ui_select").toc,
      links = require("wiki.ui_select").links,
    }
    end

}
