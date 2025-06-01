return {
    {
        "unblevable/quick-scope",
        event = "VeryLazy",
        config = function()
            -- Enable quick-scope (default is 1)
            vim.g.qs_enable = 1
            -- Catppuccin Mocha colors: Pink and Teal
            vim.api.nvim_set_hl(0, "QuickScopePrimary", { underline = true, fg = "#f5c2e7" }) -- pink
            vim.api.nvim_set_hl(0, "QuickScopeSecondary", { underline = true, fg = "#94e2d5" }) -- teal
            -- -- Set highlight colors for Dracula
            -- vim.api.nvim_set_hl(0, "QuickScopePrimary", { underline = true, fg = "#ff79c6" }) -- pink
            -- vim.api.nvim_set_hl(0, "QuickScopeSecondary", { underline = true, fg = "#8be9fd" }) -- cyan
        end,
    },
}
