return {
    {
        "nvim-telescope/telescope.nvim",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "fredrikaverpil/godoc.nvim",
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
                "ANGkeith/telescope-terraform-doc.nvim",
                dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
            },
            {
                "cappyzawa/telescope-terraform.nvim",
                dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
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
                mode = "n",
                function() require("telescope.builtin").git_files() end,
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
            -- {
            --     "<leader>pt",
            --     mode = "n",
            --     function()
            --         require("telescope.builtin").treesitter()
            --     end,
            --     desc = "telescope treesitter"
            -- },
            {
                "<leader>b",
                mode = "n",
                function() require("telescope.builtin").buffers() end,
                desc = "telescope buffers"
            },
            {
                "<leader>pv",
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
                "<leader>ptt",
                mode = "n",
                function() require("telescope").extensions.terraform.state_list() end,
                desc = "telescope terraform",
            },
            {
                "<leader>ptd",
                mode = "n",
                function() require("telescope").extensions.terraform_doc.terraform_doc() end,
                desc = "telescope terraform docs",
            }
        },
        config = function()
            local opts = {
                extensions = {
                    file_browser = {
                        respect_gitignore = false,
                        hijack_netrw = true,
                        hidden = true,
                    },
                },
            }
            require("telescope").setup(opts)
            require("telescope").load_extension("file_browser")
            require("telescope").load_extension("terraform_doc")
            require("telescope").load_extension("terraform")
        end,
    },
}
