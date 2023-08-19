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
local on_attach = function(client, bufnr)-- Enable completion triggered by <c-x><c-o>
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    --vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    --vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    --vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    --vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
    --vim.keymap.set('n', '<space>e', vim.lsp.diagnostic.show_line_diagnostics(), bufopts)
    --vim.keymap.set('n', '<space>e', vim.diagnostic.open_float(), bufopts)
    --vim.keymap.set('n', '<space>q', vim.lsp.diagnostic.set_loclist(), bufopts)
    --vim.keymap.set('n', '[d', vim.lsp.diagnostic.goto_prev(), bufopts)
    --vim.keymap.set('n', ']d', vim.lsp.diagnostic.goto_next(), bufopts)
end

-- vim.diagnostic.config({
--     virtual_text = false,
--     signs = true,
--     float = { border = "single"},
-- })
local signs = { Error = "☢️ ", Warn = "⚠️ ", Hint = "? ", Info = "ℹ️ " }
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
-- nvim_lsp.tsserver.setup {
--     on_attach = function(client)
--         if client.config.flags then
--           client.config.flags.allow_incremental_sync = true
--         end
--         client.resolved_capabilities.document_formatting = false
--         set_lsp_config(client)
--     end
-- }
-- Check if WordPress mode
is_wp, message = pcall(function()
    return vim.api.nvim_get_var("wordpress_mode")
  end)

local on_attach = function(client, bufnr)
    require 'lsp_signature'.on_attach({
      bind = true,
      floating_window = true,
      handler_opts = {
        border = "rounded"
      }
    })
    if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_augroup('lsp_document_highlight', {
        clear = false
      })
      vim.api.nvim_clear_autocmds({
        buffer = bufnr,
        group = 'lsp_document_highlight',
      })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        group = 'lsp_document_highlight',
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd('CursorMoved', {
        group = 'lsp_document_highlight',
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })
    end
end
require('lspkind').init()
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}
nvim_lsp.efm.setup {
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
nvim_lsp.ruff_lsp.setup({
    on_attach = on_attach,
    init_options = {
        settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
        }
    }
})
--nvim_lsp.pylyzer.setup({
--    on_attach = on_attach,
--    init_options = {
--        settings = {
--            -- Any extra CLI arguments for `ruff` go here.
--            args = {},
--        }
--    }
--})

-- nvim_lsp.ltex.setup({
--     settings = {
--         ltex = {
--             language = "es-ES",
--             cmd = {"ltex-ls"},
--             filetypes = {"markdown"}
--         }
--     }
-- })
-- composer global require php-stubs/wordpress-globals php-stubs/wordpress-stubs php-stubs/woocommerce-stubs php-stubs/acf-pro-stubs wpsyntex/polylang-stubs php-stubs/genesis-stubs php-stubs/wp-cli-stubs
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
            enviroment = {
                includePaths = {
                    '/home/lorenzo/.config/composer/vendor/php-stubs/',
                    '/home/lorenzo/.config/composer/vendor/wpsyntex/'}
            },
            files = {
                maxSize = 5000000;
            };
        };
    },
    capabilities = capabilities,
    on_attach = on_attach
});
if is_wp == false then
  local phpactor_capabilities = vim.lsp.protocol.make_client_capabilities()
  phpactor_capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
  }
  phpactor_capabilities['textDocument']['codeAction'] = {}
  nvim_lsp.phpactor.setup{
      capabilities = phpactor_capabilities,
      on_attach = on_attach
  }
end
nvim_lsp.cssls.setup{
    capabilities = capabilities,
    on_attach = on_attach
}
nvim_lsp.html.setup{
    capabilities = capabilities,
    on_attach = on_attach
}
nvim_lsp.bashls.setup{
    capabilities = capabilities,
    on_attach = on_attach
}

