-- Plugin from:
-- https://github.com/mickael-menu/zk-nvim
return {
    "mickael-menu/zk-nvim",
    config = function()
        local zk = require("zk")
        zk.setup({
            -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
            -- it's recommended to use "telescope" or "fzf"
            picker = "telescope",
            lsp = {
                -- `config` is passed to `vim.lsp.start_client(config)`
                config = {
                    cmd = { "zk", "lsp" },
                    name = "zk",
                    -- on_attach = ...
                    -- etc, see `:h vim.lsp.start_client()`
                },
                -- automatically attach buffers in a zk notebook that match the given filetypes
                auto_attach = {
                    enabled = true,
                    filetypes = { "markdown" },
                },
            },
        })
        local commands = require("zk.commands")
        commands.add("ZkOrphans", function(options)
            options = vim.tbl_extend("force", { orphan = true }, options or {})
            zk.edit(options, { title = "Zk Orphans" })
        end)
    end
}
