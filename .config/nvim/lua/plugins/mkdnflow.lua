--
-- https://github.com/jakewvincent/mkdnflow.nvim
--
return {
    'jakewvincent/mkdnflow.nvim',
    lazy = false,
    config = true,
    opts = {
        rocks = 'luautf8', -- Ensures optional luautf8 dependency is installed
        perspective = {
            priority = 'root',
            root_tell = ".git",
        },
        new_file_template = {
            use_template = true,
            placeholders = {
                before = {
                    title = "link_title",
                    date = "os_date"
                },
                after = {}
            },
            template = [[
---
title: {{ title }}
created_at: {{ date }}
tags:
---
# {{ title }}
<!--more-->
## {{ title }}
---
Más información,
]]
        },
    }
}
