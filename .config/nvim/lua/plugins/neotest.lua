return {
    "nvim-neotest/neotest",
    -- event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-plenary",
        "nvim-neotest/neotest-vim-test",
        "nvim-neotest/neotest-python",
        "rouge8/neotest-rust",
        "rcasia/neotest-bash",
    },
    opts = {},
    config = function()
        require("neotest").setup({
            log_level = vim.log.levels.WARN,
            adapters = {
                require("neotest-python")({
                    -- Extra arguments for nvim-dap configuration
                    -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
                    dap = { justMyCode = false },
                    -- Command line arguments for runner
                    -- Can also be a function to return dynamic values
                    args = { "--log-level", "DEBUG" },
                    -- Runner to use. Will use pytest if available by default.
                    -- Can be a function to return dynamic value.
                    runner = "unittest",
                    -- Custom python path for the runner.
                    -- Can be a string or a list of strings.
                    -- Can also be a function to return dynamic value.
                    -- If not provided, the path will be inferred by checking for
                    -- virtual envs in the local directory and for Pipenev/Poetry configs
                    python = ".venv/bin/python",
                    -- Returns if a given file path is a test file.
                    -- NB: This function is called a lot so don't perform any heavy tasks within it.
                }),
                require("neotest-rust")({
                    args = { "--no-capture" },
                    dap_adapter = "lldb",
                }),
                require("neotest-bash")
            },
            discovery = {
                enabled = true,
                concurrent = 0,
                filter_dir = nil,
            },
            running = {
                concurrent = true,
            },
            consumers = {},
            icons = {
                -- Ascii:
                -- { "/", "|", "\\", "-", "/", "|", "\\", "-"},
                -- Unicode:
                -- { "", "🞅", "🞈", "🞉", "", "", "🞉", "🞈", "🞅", "", },
                -- {"◴" ,"◷" ,"◶", "◵"},
                -- {"◢", "◣", "◤", "◥"},
                -- {"◐", "◓", "◑", "◒"},
                -- {"◰", "◳", "◲", "◱"},
                -- {"⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷"},
                -- {"⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"},
                -- {"⠋", "⠙", "⠚", "⠞", "⠖", "⠦", "⠴", "⠲", "⠳", "⠓"},
                -- {"⠄", "⠆", "⠇", "⠋", "⠙", "⠸", "⠰", "⠠", "⠰", "⠸", "⠙", "⠋", "⠇", "⠆"},
                -- { "⠋", "⠙", "⠚", "⠒", "⠂", "⠂", "⠒", "⠲", "⠴", "⠦", "⠖", "⠒", "⠐", "⠐", "⠒", "⠓", "⠋" },
                running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
                passed = "",
                running = "",
                failed = "",
                skipped = "",
                unknown = "",
                non_collapsible = "─",
                collapsed = "─",
                expanded = "╮",
                child_prefix = "├",
                final_child_prefix = "╰",
                child_indent = "│",
                final_child_indent = " ",
                watching = "",
            },
            highlights = {
                passed = "NeotestPassed",
                running = "NeotestRunning",
                failed = "NeotestFailed",
                skipped = "NeotestSkipped",
                test = "NeotestTest",
                namespace = "NeotestNamespace",
                focused = "NeotestFocused",
                file = "NeotestFile",
                dir = "NeotestDir",
                border = "NeotestBorder",
                indent = "NeotestIndent",
                expand_marker = "NeotestExpandMarker",
                adapter_name = "NeotestAdapterName",
                select_win = "NeotestWinSelect",
                marked = "NeotestMarked",
                target = "NeotestTarget",
                unknown = "NeotestUnknown",
                watching = "NeotestWatching",
            },
            floating = {
                border = "rounded",
                max_height = 0.6,
                max_width = 0.6,
                options = {},
            },
            default_strategy = "integrated",
            strategies = {
                integrated = {
                    width = 120,
                    height = 40,
                },
            },
            summary = {
                enabled = true,
                animated = true,
                follow = true,
                expand_errors = true,
                open = "botright vsplit | vertical resize 50",
                mappings = {
                    expand = { "<CR>", "<2-LeftMouse>" },
                    expand_all = "e",
                    output = "o",
                    short = "O",
                    attach = "a",
                    jumpto = "i",
                    stop = "u",
                    run = "r",
                    debug = "d",
                    mark = "m",
                    run_marked = "R",
                    debug_marked = "D",
                    clear_marked = "M",
                    target = "t",
                    clear_target = "T",
                    next_failed = "J",
                    prev_failed = "K",
                    watch = "w",
                },
            },
            benchmark = {
                enabled = true,
            },
            output = {
                enabled = true,
                open_on_run = "short",
            },
            output_panel = {
                enabled = true,
                open = "botright split | resize 15",
            },
            diagnostic = {
                enabled = true,
                severity = vim.diagnostic.severity.ERROR,
            },
            status = {
                enabled = true,
                virtual_text = false,
                signs = true,
            },
            run = {
                enabled = true,
            },
            jump = {
                enabled = true,
            },
            quickfix = {
                enabled = true,
                open = false,
            },
            state = {
                enabled = true,
            },
            watch = {
                enabled = true,
                symbol_queries = {
                    python = [[
        ;query
        ;Captures imports and modules they're imported from
        (import_from_statement (_ (identifier) @symbol))
        (import_statement (_ (identifier) @symbol))
      ]],
                    go = [[
        ;query
        ;Captures imported types
        (qualified_type name: (type_identifier) @symbol)
        ;Captures package-local and built-in types
        (type_identifier)@symbol
        ;Captures imported function calls and variables/constants
        (selector_expression field: (field_identifier) @symbol)
        ;Captures package-local functions calls
        (call_expression function: (identifier) @symbol)
      ]],
                    lua = [[
        ;query
        ;Captures module names in require calls
        (function_call
          name: ((identifier) @function (#eq? @function "require"))
          arguments: (arguments (string) @symbol))
      ]],
                    elixir = function(root, content)
                        local query = require("neotest.lib").treesitter.normalise_query(
                            "elixir",
                            [[;; query
            (call (identifier) @_func_name
              (arguments (alias) @symbol)
              (#match? @_func_name "^(alias|require|import|use)")
              (#gsub! @symbol ".*%.(.*)" "%1")
            )
          ]]
                        )
                        local symbols = {}
                        for _, match, metadata in query:iter_matches(root, content) do
                            for id, node in pairs(match) do
                                local name = query.captures[id]

                                if name == "symbol" then
                                    local start_row, start_col, end_row, end_col = node:range()
                                    if metadata[id] ~= nil then
                                        local real_symbol_length = string.len(metadata[id]["text"])
                                        start_col = end_col - real_symbol_length
                                    end

                                    symbols[#symbols + 1] = { start_row, start_col, end_row, end_col }
                                end
                            end
                        end
                        return symbols
                    end,
                    ruby = [[
        ;query
        ;rspec - class name
        (call
          method: (identifier) @_ (#match? @_ "^(describe|context)")
          arguments: (argument_list (constant) @symbol )
        )

        ;rspec - namespaced class name
        (call
          method: (identifier)
          arguments: (argument_list
            (scope_resolution
              name: (constant) @symbol))
        )
      ]],
                },
                filter_path = nil,
            },
            projects = {},
        })
    end,
}
