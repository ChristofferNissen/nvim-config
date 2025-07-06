return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "fredrikaverpil/neotest-golang",
            -- "Issafalcon/neotest-dotnet",
            "nsidorenco/neotest-vstest",
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    -- require("neotest-dotnet")({
                    --     dap_settings = {
                    --         type = "netcoredbg",
                    --     },
                    -- }),
                    require("neotest-vstest")({
                        -- sdk_path = "/etc/profiles/per-user/cn/bin/dotnet",
                        -- table is passed directly to DAP when debugging tests.
                        dap_settings = {
                            type = "netcoredbg",
                        },
                        -- If multiple solutions exists the adapter will ask you to choose one.
                        -- If you have a different heuristic for choosing a solution you can provide a function here.
                        -- solution_selector = function(solutions)
                        --     return nil -- return the solution you want to use or nil to let the adapter choose.
                        -- end,
                    }),
                    ["neotest-golang"] = {
                        -- Here we can set options for neotest-golang, e.g.
                        -- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
                        dap_go_enabled = true, -- requires leoluz/nvim-dap-go
                    },
                },
                status = { virtual_text = true },
                output = { open_on_run = true },
                quickfix = {
                    open = function()
                        require("trouble").open({ mode = "quickfix", focus = false })
                    end,
                },
            })
        end,
    },
}
