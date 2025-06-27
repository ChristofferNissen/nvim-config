return {
    {
        "rachartier/tiny-code-action.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            -- { "nvim-telescope/telescope.nvim" },
        },
        event = "LspAttach",
        opts = {
            picker = {
                "buffer",
                opts = {
                    hotkeys = true,
                    hotkeys_mode = "text_diff_based",
                },
            },
        },
    },
}
