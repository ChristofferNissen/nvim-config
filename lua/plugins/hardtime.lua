return {
    -- {
    --
    --     "tris203/precognition.nvim",
    --     event = "VeryLazy",
    --     opts = {
    --         -- startVisible = true,
    --         -- showBlankVirtLine = true,
    --         -- highlightColor = { link = "Comment" },
    --         -- hints = {
    --         --      Caret = { text = "^", prio = 2 },
    --         --      Dollar = { text = "$", prio = 1 },
    --         --      MatchingPair = { text = "%", prio = 5 },
    --         --      Zero = { text = "0", prio = 1 },
    --         --      w = { text = "w", prio = 10 },
    --         --      b = { text = "b", prio = 9 },
    --         --      e = { text = "e", prio = 8 },
    --         --      W = { text = "W", prio = 7 },
    --         --      B = { text = "B", prio = 6 },
    --         --      E = { text = "E", prio = 5 },
    --         -- },
    --         -- gutterHints = {
    --         --     G = { text = "G", prio = 10 },
    --         --     gg = { text = "gg", prio = 9 },
    --         --     PrevParagraph = { text = "{", prio = 8 },
    --         --     NextParagraph = { text = "}", prio = 8 },
    --         -- },
    --         -- disabled_fts = {
    --         --     "startify",
    --         -- },
    --     },
    -- },
    {
        "unblevable/quick-scope",
        -- event = "VeryLazy",
        config = function()
            -- Enable quick-scope (default is 1)
            vim.g.qs_enable = 1
            -- Catppuccin Mocha colors: Pink and Teal
            vim.api.nvim_set_hl(0, "QuickScopePrimary", { underline = true, fg = "#f5c2e7" })   -- pink
            vim.api.nvim_set_hl(0, "QuickScopeSecondary", { underline = true, fg = "#94e2d5" }) -- teal
            -- -- Set highlight colors for Dracula
            -- vim.api.nvim_set_hl(0, "QuickScopePrimary", { underline = true, fg = "#ff79c6" }) -- pink
            -- vim.api.nvim_set_hl(0, "QuickScopeSecondary", { underline = true, fg = "#8be9fd" }) -- cyan
        end
    },
    -- {
    --     "m4xshen/hardtime.nvim",
    --     lazy = false,
    --     dependencies = { "MunifTanjim/nui.nvim" },
    --     opts = {
    --     },
    -- },
}
