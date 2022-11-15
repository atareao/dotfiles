require("workspaces").setup({
    hooks = {
        open = {"Neotree", "Telescope find_files",
        function()
          require("sessions").load('.nvim/session', { silent = true })
        end,
        }
    }
})
local telescope = require("telescope")
telescope.load_extension("workspaces")
