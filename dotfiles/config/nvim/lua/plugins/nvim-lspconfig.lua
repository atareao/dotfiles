-----------------------------------------------------------
-- Neovim LSP configuration file
-----------------------------------------------------------

-- Plugin: nvim-lspconfig
-- for language server setup see: https://github.com/neovim/nvim-lspconfig

local nvim_lsp = require('lspconfig')

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- vim.diagnostic.config({
--     virtual_text = false,
--     signs = true,
--     float = { border = "single"},
-- })
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

--[[

Language servers:

Add your language server to `servers`

For language servers list see:
https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md

Bash --> bashls
https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#bashls

Python --> pyright
https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#pyright

C-C++ -->  clangd
https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#clangd

HTML/CSS/JSON --> vscode-html-languageserver
https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#html

JavaScript/TypeScript --> tsserver
https://github.com/typescript-language-server/typescript-language-server

--]]

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'bashls', 'pyright', 'clangd', 'html', 'tsserver'}--, 'tsserver'

-- Set settings for language servers below
--
-- tsserver settings
local ts_settings = function(client)
  client.resolved_capabilities.document_formatting = false
  ts_settings(client)
end

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    ts_settings = ts_settings,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
-- require "lspconfig".tsserver.setup {
--     on_attach = function(client)
--         if client.config.flags then
--           client.config.flags.allow_incremental_sync = true
--         end
--         client.resolved_capabilities.document_formatting = false
--         set_lsp_config(client)
--     end
-- }
require "lspconfig".efm.setup {
    init_options = {documentFormatting = true},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            javascript = {
                lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
                lintStdin = true,
                lintFormats = {
                    "%f:%l:%c: %m"
                },
                lintIgnoreExitCode = true,
                formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
                formatStdin = true
            },
            sh = {
                {LintCommand = "shellcheck -f gcc -x",
                 LintFormats = {
                     "%f:%l:%c: %trror: %m",
                     "%f:%l:%c: %tarning: %m",
                     "%f:%l:%c: %tote: %m"}
                 }
            },
            dockerfile = {
                {
                    LintCommand = "hadolint --no-color",
                    LintFormats = {
                        "%f:%l %m",
                    }
                }
            },
            python = {
                {
                    LintCommand = "mypy --show-column-numbers",
                    LintFormats = {
                        "%f:%l:%c: %trror: %m",
                        "%f:%l:%c: %tarning: %m",
                        "%f:%l:%c: %tote: %m"
                    }
                },
                {
                    LintCommand = "flake8 --stdin-display-name ${INPUT} -",
                    LintFormats = {
                        "%f:%l:%c: %m"
                    }
                },
                {
                    LintCommand = "pylint --output-format text --score no --msg-template {path}:{line}:{column}:{C}:{msg} ${INPUT}",
                    LintFormats = {
                        "%f:%l:%c:%t:%m"
                    }
                },
                {
                    FormatCommand = "autopep8 -"
                }
                --{
                --    FormatCommand = {"autopep8 -", FormatStdin = true}
                --}
            }
        }
    }
    --settings = {
    --    filetypes = {"python"},
    --    languages = {
    --      python = {formatCommand = "autopep8 -", formatStdin = true}
    --    }
    --}
}
nvim_lsp.rust_analyzer.setup({
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
            diagnostics = {
              enable = true,
              disabled = {"unresolved-proc-macro", "macro-error"},
              enableExperimental = true,
          },
        }
    }
})
nvim_lsp.intelephense.setup({
  settings = {
        intelephense = {
            stubs = {
                "acf-pro",
                "apache",
                "bcmath",
                "bz2",
                "calendar",
                "com_dotnet",
                "Core",
                "ctype",
                "curl",
                "date",
                "dba",
                "dom",
                "enchant",
                "exif",
                "FFI",
                "fileinfo",
                "filter",
                "fpm",
                "ftp",
                "gd",
                "gettext",
                "gmp",
                "hash",
                "iconv",
                "imap",
                "intl",
                "json",
                "ldap",
                "libxml",
                "mbstring",
                "meta",
                "mysqli",
                "oci8",
                "odbc",
                "openssl",
                "pcntl",
                "pcre",
                "PDO",
                "pdo_ibm",
                "pdo_mysql",
                "pdo_pgsql",
                "pdo_sqlite",
                "pgsql",
                "Phar",
                "polylang",
                "posix",
                "pspell",
                "readline",
                "Reflection",
                "session",
                "shmop",
                "SimpleXML",
                "snmp",
                "soap",
                "sockets",
                "sodium",
                "SPL",
                "sqlite3",
                "standard",
                "superglobals",
                "sysvmsg",
                "sysvsem",
                "sysvshm",
                "tidy",
                "tokenizer",
                "wordpress",
                "wordpress-globals",
                "wp-cli",
                "xml",
                "xmlreader",
                "xmlrpc",
                "xmlwriter",
                "xsl",
                "Zend OPcache",
                "zip",
                "zlib"
            },
            files = {
                maxSize = 5000000;
            };
        };
    }
});
