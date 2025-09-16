return {
    {
        "Eutrius/Otree.nvim",
        lazy = false,
        dependencies = {
            {
                "stevearc/oil.nvim",
                ---@module 'oil'
                ---@type oil.SetupOpts
                opts = {
                    -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
                    -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
                    default_file_explorer = false,
                    delete_to_trash = true,
                    -- skip_confirm_for_simple_edits = true,
                    view_options = {
                        show_hidden = true,
                        natural_order = true,
                        is_always_hidden = function(name, _)
                            return name == ".." or name == ".git"
                        end,
                    },
                    win_options = {
                        wrap = true,
                    },
                },
                -- Optional dependencies
                dependencies = { { "echasnovski/mini.icons", opts = {} } },
                -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
                lazy = false,
                event = "VeryLazy",
            },
            { "echasnovski/mini.icons", opts = {} },
        },
        config = function()
            require("Otree").setup({
                win_size = 35,
                open_on_startup = false,
                use_default_keymaps = true,
                hijack_netrw = true,
                show_hidden = true,
                show_ignore = true,
                git_signs = true,
                ignore_patterns = { "node_modules", ".git", ".cache" },
            })
            vim.keymap.set("n", "<leader>t", "<Cmd>Otree<CR>")
        end,
    },
}
