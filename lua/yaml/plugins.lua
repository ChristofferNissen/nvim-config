return {
    {
        "ChristofferNissen/azure-pipelines.nvim",
        event = { "BufReadPre", "BufNewFile" },
        ft = "yaml",
        config = function()
            require("azure_pipelines")
        end,
    },
    {
        "ChristofferNissen/yaml-schema-detect.nvim",
        config = true,
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        ft = { "yaml" },
    },
    {
        "jfryy/keytrail.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        ft = { "yaml", "json", "azure_pipelines" },
        event = "VeryLazy",
        opts = {
            ft = {
                json = true,
                yaml = true,
                azure_pipelines = true,
            },
        },
        config = function(opts)
            require("keytrail").setup(opts)
        end,
    },
    {
        "b0o/SchemaStore.nvim",
        lazy = true,
        version = false, -- last release is way too old
    },
    {
        "stephpy/vim-yaml",
    },
    {
        "towolf/vim-helm",
    },
}
