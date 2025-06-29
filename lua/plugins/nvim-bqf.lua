return {
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        config = function()
            require("bqf").setup({
                -- add your custom setup here if needed
            })
        end,
    },
}
