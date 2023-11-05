return {
    "williamboman/mason-lspconfig.nvim", -- optional
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim", -- optional
        "folke/lsp-colors.nvim",
        "simrat39/inlay-hints.nvim"
    },
    config = function()
        local mason_status_ok, mason = pcall(require, "mason")
        if not mason_status_ok then
            return
        end

        local lsp_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
        if not lsp_status_ok then
            return
        end

        --local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
        --if not mason_null_ls_status then
        --    return
        --end

        local config = {
            -- enable virtual text
            virtual_text = false,
            signs = true,
            update_in_insert = false,
            underline = true,
            severity_sort = false,
            float = {
                focusable = true,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
                -- width = 40,
            },
        }
        vim.o.updatetime = 250
        vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local feedkey = function(key, mode)
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
        end

        local on_attach = function(client, bufnr)
            local bufopts = { noremap=true, silent=true, buffer=bufnr }
            vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, bufopts)
        end

        -- Pyright
        local configs = require('lspconfig/configs')
        local util = require('lspconfig/util')

        local path = util.path
        local function get_python_path(workspace)
            -- Use activated virtualenv.
            if vim.env.VIRTUAL_ENV then
                return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
            end

            -- Find and use virtualenv in workspace directory.
            for _, pattern in ipairs({'*', '.*'}) do
                local match = vim.fn.glob(path.join(workspace, pattern, 'pyvenv.cfg'))
                if match ~= '' then
                    return path.join(path.dirname(match), 'bin', 'python')
                end
            end

            -- Fallback to system Python.
            return exepath('python3') or exepath('python') or 'python'
        end

        require("lspconfig").pyright.setup{
            before_init = function(_, config)
                config.settings.python.pythonPath = get_python_path(config.root_dir)
            end,
            on_attach = on_attach,
            capabilities = capabilities,
        }


        vim.diagnostic.config(config)
        require("inlay-hints").setup()
        --local servers = {
        --    "rust_analyzer", "bashls", "efm", "html", "jsonls",
        --    "intelephense", "phpactor", "tsserver", "marksman", "pyright",
        --    "pylsp", "ruff_lsp", "sqlls"
        --}
        mason.setup()
        mason_lspconfig.setup({
            ensure_installed = servers,
            -- auto-install configured servers (with lspconfig)
            automatic_installation = true, -- not the same as ensure_installed
        })

        local servers = {
            efm = {
                init_options = {documentFormatting = true},
                settings = {
                    rootMarkers = {".git/"},
                    languages = {
                        lua = {
                            {formatCommand = "lua-format -i", formatStdin = true}
                        }
                    }
                }
            },
            pyright = {},
            ruff_lsp = {},
            pylsp = {},
            marksman = {}
        }

        mason_lspconfig.setup {
            ensure_installed = vim.tbl_keys(servers),
        }

        mason_lspconfig.setup_handlers {
            function(server_name)
                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                }
            end,
        }
        --------------------------------------------------------------------------------
        -- activate each lsp in the list
        --------------------------------------------------------------------------------
        for _, lsp in ipairs(servers) do
            local generic_opts = {
                capabilities = capabilities,
                on_attach = handlers.on_attach,
                flags = { debounce_text_changes = 150 },
            }
            local specialized_opts = option_lookup[lsp]
            if specialized_opts == nil then
                lspconfig[lsp].setup(generic_opts)
            else
                local opts = vim.tbl_deep_extend(
                    "force",
                    generic_opts,
                    specialized_opts
                )
                lspconfig[lsp].setup(opts)
            end
        end
    end,
}

