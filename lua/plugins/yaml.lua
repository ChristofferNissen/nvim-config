return {
    {
        "stephpy/vim-yaml",
    },
    {
        "towolf/vim-helm",
    },
    {
        "someone-stole-my-name/yaml-companion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {},
        ft = { "yaml" }, -- Load only for YAML files
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
        event = { "BufReadPre", "BufNewFile" },
        ft = "yaml",
        config = function()
            require("azure_pipelines")
        end,
    },
}
