return {
    {
        "stephpy/vim-yaml",
        ft = "yaml",
    },
    {
        "towolf/vim-helm",
        ft = { "yaml", "helm" },
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
        "ChristofferNissen/azure-pipelines.vim",
        ft = { "yaml", "azure_pipelines" },
        config = function()
            require("azure_pipelines")
        end,
    },
}
