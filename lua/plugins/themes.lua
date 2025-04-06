return {
    {
        "catppuccin/nvim",
        name = "catppuccin-mocha",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme catppuccin-mocha]])
        end,
    },
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    -- }
    -- {
    --     "dracula/vim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    --     config = function()
    --         vim.cmd([[colorscheme dracula]])
    --     end
    -- },
}
