return {
    {
        "ChristofferNissen/azure-pipelines.vim",
        event = { "BufReadPre", "BufNewFile" },
        ft = "yaml",
        config = function()
            require("azure_pipelines")
        end,
    },
}
