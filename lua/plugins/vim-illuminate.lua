return {
    {
        "RRethy/vim-illuminate",
        config = function()
            -- Optional: your configuration for vim-illuminate can go here
            vim.g.Illuminate_delay = 100
        end,
        event = "VeryLazy", -- Load on a lazy event, or you can use "BufReadPost" etc.
    },
}
