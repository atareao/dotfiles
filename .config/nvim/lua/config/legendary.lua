require('legendary').setup({
    keymaps = {
        -- map keys to a command
        { '<leader>ff', ':Telescope find_files', description = 'Find files' },
        -- Trouble
        { '<leader>xx', ':Trouble<CR>', description = 'Open Trouble window'},
        { '<leader>xw', ':Trouble workspace_diagnostics<CR>', description = 'Diagnostics' },
        {'<leader>xd', ':Trouble document_diagnostics<CR>', description = 'Documents'},
        {'<leader>xl', ':Trouble loclist<CR>', description = 'List' },
        {'<leader>xq', ':Trouble quickfix<CR>', description = 'QuickFix'},
        {'gR', ':Trouble lsp_references<CR>', description = 'Preferences'},

    -- map keys to a function
    { '<leader>h', function() print('hello world!') end, description = 'Say hello' },
    -- keymaps have opts.silent = true by default, but you can override it
    { '<leader>s', ':SomeCommand<CR>', description = 'Non-silent keymap', opts = { silent = false } },
    -- create keymaps with different implementations per-mode
    {
      '<leader>c',
      { n = ':LinewiseCommentToggle<CR>', x = ":'<,'>BlockwiseCommentToggle<CR>" },
      description = 'Toggle comment'
    },
  },
  commands = {
    -- easily create user commands
    { ':SayHello', function() print('hello world!') end, description = 'Say hello as a command' },
  },
  autocmds = {
    -- Create autocmds and augroups
    { 'BufWritePre', vim.lsp.buf.format, description = 'Format on save' },
    {
      name = 'MyAugroup',
      clear = true,
      -- autocmds here
    },
  },
  funcs = {
    -- Make arbitrary Lua functions that can be executed via the item finder
    {
        function()
            doSomeStuff()
        end,
        description = 'Do some stuff with a Lua function!' },
  },
})
