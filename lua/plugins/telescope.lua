return {
    {
        "nvim-telescope/telescope.nvim",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "fredrikaverpil/godoc.nvim",
                event = "VeryLazy",
            },
            {
                "nvim-telescope/telescope-file-browser.nvim",
                event = "VeryLazy",
                dependencies = {
                    "nvim-telescope/telescope.nvim",
                    "nvim-lua/plenary.nvim",
                    "nvim-tree/nvim-web-devicons",
                },
            },
            {
                "nvim-telescope/telescope-ui-select.nvim",
                event = "VeryLazy",
            },
            {
                "benfowler/telescope-luasnip.nvim",
                event = "VeryLazy",
            },
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            {
                "ANGkeith/telescope-terraform-doc.nvim",
                event = "VeryLazy",
                dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
            },
            {
                "cappyzawa/telescope-terraform.nvim",
                event = "VeryLazy",
                dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
            },
            { "jvgrootveld/telescope-zoxide" },
            { "debugloop/telescope-undo.nvim" },
            {
                "tomasky/bookmarks.nvim",
                event = "VimEnter",
                config = function()
                    require("bookmarks").setup({
                        save_file = vim.fn.expand("$HOME/.bookmarks"), -- bookmarks save file path
                        on_attach = function(bufnr)
                            local bm = require("bookmarks")
                            local map = vim.keymap.set
                            map("n", "mm", bm.bookmark_toggle) -- add or remove bookmark at current line
                            map("n", "mi", bm.bookmark_ann) -- add or edit mark annotation at current line
                            map("n", "mc", bm.bookmark_clean) -- clean all marks in local buffer
                            map("n", "mn", bm.bookmark_next) -- jump to next mark in local buffer
                            map("n", "mp", bm.bookmark_prev) -- jump to previous mark in local buffer
                            map("n", "ml", bm.bookmark_list) -- show marked file list in quickfix window
                            map("n", "mx", bm.bookmark_clear_all) -- removes all bookmarks
                        end,
                    })
                end,
            },
            {
                "folke/noice.nvim",
            },
            {
                "danielfalk/smart-open.nvim",
                branch = "0.2.x",
                config = function()
                    require("telescope").load_extension("smart_open")
                end,
                dependencies = {
                    "kkharji/sqlite.lua",
                    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
                    { "nvim-telescope/telescope-fzy-native.nvim" },
                },
            },
        },
        -- stylua: ignore
        keys = {
            {
                "<leader>pf",
                mode = "n",
                function() require("telescope.builtin").find_files() end,
                desc = "telescope find files"
            },
            {
                "<C-p>",
                -- "<leader>e",
                mode = "n",
                -- function() require("telescope.builtin").git_files() end,
                function()
                    require("telescope").extensions.smart_open.smart_open()
                end,
                desc = "telescope find files"
            },
            {
                "<leader>pcd",
                mode = "n",
                function()
                    require("telescope").extensions.zoxide.list()
                end,
                desc = "telescope zoxide"
            },
            {
                "<leader>ps",
                mode = "n",
                function()
                    require("telescope.builtin").live_grep()
                end,
                desc = "telescope grep string"
            },
            {
                "<leader>pa",
                mode = "n",
                function()
                    require 'telescope'.extensions.luasnip.luasnip()
                end,
                desc = "telescope snippets"
            },
            {
                "<leader>pm",
                mode = "n",
                function()
                    require 'telescope'.extensions.bookmarks.list()
                end,
                desc = "telescope bookmarks"
            },
            -- {
            --     "<leader>pt",
            --     mode = "n",
            --     function()
            --         require("telescope.builtin").treesitter()
            --     end
            --     desc = "telescope treesitter"
            -- },
            {
                "<leader>pb",
                mode = "n",
                function() require("telescope.builtin").buffers() end,
                desc = "telescope buffers"
            },
            {
                "<leader>pv",
                -- "<leader>e",
                mode = "n",
                function() require("telescope").extensions.file_browser.file_browser() end,
                desc = "telescope file browser"
            },
            {
                "<leader>pr",
                mode = "n",
                function() require("telescope.builtin").resume() end,
                desc = "telescope resume",
            },
            {
                "<leader>pg",
                mode = "n",
                function() require("godoc").show_telescope_picker() end,
                desc = "telescope godoc",
            },
            {
                "<leader>py",
                mode = "n",
                function() require("yaml_nvim").telescope() end,
                desc = "telescope YAML",
            },
            {
                "<leader>pu",
                mode = "n",
                function() require("telescope").extensions.undo.undo() end,
                desc = "telescope undo",
            },
            {
                "<leader>pts",
                mode = "n",
                function() require("telescope").extensions.terraform.state_list() end,
                desc = "telescope terraform",
            },
            {
                "<leader>ptp",
                mode = "n",
                function() require("telescope").extensions.terraform_doc.terraform_doc() end,
                desc = "telescope terraform docs",
            }
        },
        config = function()
            local themes = require("telescope.themes")
            local opts = {
                extensions = {
                    file_browser = {
                        respect_gitignore = false,
                        hijack_netrw = false,
                        hidden = true,
                    },
                    luasnip = themes.get_dropdown({
                        -- border = false,
                        preview = {
                            check_mime_type = true,
                        },
                    }),
                },
            }
            require("telescope").setup(opts)
            require("telescope").load_extension("file_browser")
            require("telescope").load_extension("terraform_doc")
            require("telescope").load_extension("terraform")
            require("telescope").load_extension("ui-select")
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("luasnip")
            require("telescope").load_extension("noice")
            require("telescope").load_extension("zoxide")
            require("telescope").load_extension("bookmarks")
            require("telescope").load_extension("undo")
        end,
    },
}
