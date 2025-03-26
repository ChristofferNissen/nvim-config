return {
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
        event = { "BufReadPost", "BufNewFile" },
    },
    {
        "nat-418/boole.nvim",
        config = function()
            require("boole").setup({
                mappings = {
                    increment = "<C-a>",
                    decrement = "<C-x>",
                },
                additions = {
                    { "Foo", "Bar" },
                    { "tic", "tac", "toe" },
                },
                allow_caps_additions = {
                    { "enable", "disable" },
                },
            })
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
        opts = {},
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        optional = true,
        event = "LazyFile",
        opts = {
            scope = { enabled = false },
        },
    },
    {
        "gbprod/substitute.nvim",
        -- stylua: ignore
        keys = {
            { "<leader>r",  mode = "n", function() require('substitute').operator() end, desc = "substitute w/ motion" },
            { "<leader>rr", mode = "n", function() require('substitute').line() end,     desc = "substitute w/ line" },
            { "<leader>R",  mode = "n", function() require('substitute').eol() end,      desc = "substitute w/ eol" },
            { "<leader>r",  mode = "x", function() require('substitute').visual() end,   desc = "substitute w/ visual" },
        },
        opts = {},
    }
}
