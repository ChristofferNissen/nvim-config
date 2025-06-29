return {
    {
        "RRethy/vim-illuminate",
        config = function()
            -- Optional: your configuration for vim-illuminate can go here
            -- Example: Change delay before highlighting
            vim.g.Illuminate_delay = 500
        end,
        event = "VeryLazy", -- Load on a lazy event, or you can use "BufReadPost" etc.
    },
}
