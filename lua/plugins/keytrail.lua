return {
    {
        "jfryy/keytrail.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim",
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
}
