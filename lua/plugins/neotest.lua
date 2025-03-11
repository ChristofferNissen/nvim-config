return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap",
        },
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            {
                "fredrikaverpil/neotest-golang", -- Installation
                dependencies = {
                    "leoluz/nvim-dap-go",
                },
            },
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-golang"), -- Registration
                },
            })
        end,
    },
}
