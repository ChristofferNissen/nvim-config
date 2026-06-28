return {
    {
        "towolf/vim-helm",
        ft = { "yaml", "helm" },
    },
    {
        "ChristofferNissen/yaml-schema-detect.nvim",
        config = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        ft = "yaml",
    },
    {
        "ChristofferNissen/azure-pipelines.vim",
        ft = { "yaml", "azure_pipelines" },
        config = function()
            require("azure_pipelines")
        end,
    },
}
