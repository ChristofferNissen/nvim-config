return {
    {
        "b0o/SchemaStore.nvim",
        lazy = true,
        version = false, -- last release is way too old
    },
    {
        'towolf/vim-helm',
        ft = 'helm'
    },
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
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        opts = {
            modes = { insert = true, command = true, terminal = false },
            -- skip autopair when next character is one of these
            skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
            -- skip autopair when the cursor is inside these treesitter nodes
            skip_ts = { "string" },
            -- skip autopair when next character is closing pair
            -- and there are more closing pairs than opening pairs
            skip_unbalanced = true,
            -- better deal with markdown code blocks
            markdown = true,
        },
        version = false,
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
    },
    {
        "mfussenegger/nvim-lint",
        optional = true,
        opts = {
            linters_by_ft = {
                terraform = { "terraform_validate" },
                tf = { "terraform_validate" },
            },
        },
    },
}
