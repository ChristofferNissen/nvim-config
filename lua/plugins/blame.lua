return {
    {
        "FabijanZulj/blame.nvim",
        lazy = false,
        config = function(opts)
            require("blame").setup(opts)
        end,
    },
}
