return {
    {
        "Eutrius/Otree.nvim",
        lazy = false,
        dependencies = {
            "stevearc/oil.nvim",
            { "echasnovski/mini.icons", opts = {} },
            -- "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("Otree").setup()
            vim.keymap.set("n", "<leader>t", "<Cmd>OtreeFocus<CR>")
        end,
    },
    {
        "stevearc/oil.nvim",
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
            -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
            -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
            default_file_explorer = false,
        },
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
        event = "VeryLazy",
    },
}
