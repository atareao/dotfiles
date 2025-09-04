-- return {
--     'kaarmu/typst.vim',
--     ft = 'typst',
--     lazy = false,
-- }

return {
  'chomosuke/typst-preview.nvim',
  lazy = false, -- or ft = 'typst'
  version = '1.*',
  opts = {
        open_cmd = "qutebrowser %s",
    }, -- lazy.nvim will implicitly calls `setup {}`
}
