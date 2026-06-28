return {
    {
        "jfryy/keytrail.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        ft = { "yaml", "json", "azure_pipelines" },
        -- event = "VeryLazy",
        opts = {
            ft = {
                json = true,
                yaml = true,
                azure_pipelines = true,
            },
        },
        config = function(_, opts)
            require("keytrail").setup(opts)
        end,
    },
}
