return {
    --[[ https://dotfyle.com/neovim/colorscheme/top ]]
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function(opts)
    --         require("tokyonight").setup(opts)
    --         vim.cmd([[colorscheme tokyonight-storm]])
    --     end,
    --     opts = {
    --         style = "storm",
    --     },
    -- },
    -- {
    --     "rose-pine/neovim",
    --     name = "rose-pine",
    --     config = function()
    --         vim.cmd([[colorscheme rose-pine-moon]])
    --     end,
    -- },
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
    --     "dracula/vim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    --     config = function()
    --         vim.cmd([[colorscheme dracula]])
    --     end
    -- },
}
