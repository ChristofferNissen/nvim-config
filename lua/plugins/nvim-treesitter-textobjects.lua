return {
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            -- You can add your Treesitter textobjects config here if desired
            -- For example, enable specific modules in require("nvim-treesitter.configs").setup
        end,
        event = "VeryLazy", -- or "BufReadPre" or your preferred lazy-load event
    },
}
