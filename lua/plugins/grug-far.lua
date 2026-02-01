return {
    {
        "MagicDuck/grug-far.nvim",
        -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
        -- additional lazy config to defer loading is not really needed...
        config = function()
            -- optional setup call to override plugin options
            -- alternatively you can set options with vim.g.grug_far = { ... }
            require("grug-far").setup({
                -- options, see Configuration section below
                headerMaxWidth = 80,
            })
        end,
        keys = {
            {
                "<leader>bi",
                function()
                    require("grug-far").open({
                        transient = true,
                        visualSelectionUsage = "operate-within-range",
                        prefills = { paths = vim.fn.expand("%") },
                    })
                end,
                mode = { "n", "x" },
                desc = "grug-far: Search within range",
            },
            {
                "<leader>bf",
                function()
                    require("grug-far").open({ transient = true })
                end,
                mode = { "n", "x" },
                desc = "grug-far: Search within range",
            },
        },
    },
}
