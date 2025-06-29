return {
    -- {
    --     "Willem-J-an/nvim-dap-powershell",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "mfussenegger/nvim-dap",
    --         "rcarriga/nvim-dap-ui",
    --         {
    --             "m00qek/baleia.nvim",
    --             lazy = true,
    --             tag = "v1.4.0",
    --         },
    --     },
    --     config = function(opts)
    --         require("dap-powershell").setup(opts)
    --     end,
    --     opts = {
    --         pses_bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
    --     },
    -- },
    {
        "TheLeoP/powershell.nvim",
        ---@type powershell.user_config
        opts = {
            bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
        },
    },
}
