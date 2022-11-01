local sj = require("sj")
sj.setup()

vim.keymap.set("n", "<leader>sj", sj.run)
vim.keymap.set("n", "<A-,>", sj.prev_match)
vim.keymap.set("n", "<A-;>", sj.next_match)
vim.keymap.set("n", "<localleader>s", sj.redo)
