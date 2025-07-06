return {
    {
        "ChristofferNissen/yaml-schema-detect.nvim",
        config = true,
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        ft = { "yaml" },
    },
}
