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
            vim.keymap.set({ "n", "x" }, "<leader>bi", function()
                require("grug-far").open({
                    transienf = true,
                    visualSelectionUsage = "operate-within-range",
                    prefills = { paths = vim.fn.expand("%") },
                })
            end, { desc = "grug-far: Search within range" })
            vim.keymap.set({ "n", "x" }, "<leader>bf", function()
                -- require("grug-far").open({ visualSelectionUsage = "operate-within-range" })
                require("grug-far").open({ transient = true })
            end, { desc = "grug-far: Search within range" })
        end,
    },
}
