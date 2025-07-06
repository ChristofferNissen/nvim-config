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
                    "echasnovski/mini.icons",
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
            {
                "danielfalk/smart-open.nvim",
                branch = "0.2.x",
                config = function()
                    require("telescope").load_extension("smart_open")
                end,
                dependencies = {
                    "kkharji/sqlite.lua",
                    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
                    -- { "nvim-telescope/telescope-fzy-native.nvim" },
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
        end,
    },
}
