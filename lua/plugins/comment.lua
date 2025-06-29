return {
    {
        "numToStr/Comment.nvim",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        opts = {},
        event = { "BufReadPost", "BufNewFile" },
    },
}
