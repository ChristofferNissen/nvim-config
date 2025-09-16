return {
    -- increment/decrement values
    {
        "ChristofferNissen/boole.nvim",
        event = "VeryLazy",
        lazy = true,
        config = function()
            require("boole").setup({
                mappings = {
                    increment = "<C-a>",
                    decrement = "<C-x>",
                },
                additions = {
                    { "Foo", "Bar" },
                    { "tic", "tac", "toe" },
                },
                allow_caps_additions = {
                    { "enable", "disable" },
                },
            })
        end,
    },
    -- improved comments
    {
        "numToStr/Comment.nvim",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        opts = {},
        event = { "BufReadPost", "BufNewFile" },
    },
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
    {
        "MagicDuck/grug-far.nvim",
        -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
        -- additional lazy config to defer loading is not really needed...
        config = function()
            -- optional setup call to override plugin options
            -- alternatively you can set options with vim.g.grug_far = { ... }
            require("grug-far").setup({
                -- options, see Configuration section below
                headerMaxWidth = 80,
            })
            vim.keymap.set({ "n", "x" }, "<leader>gi", function()
                require("grug-far").open({
                    transienf = true,
                    visualSelectionUsage = "operate-within-range",
                    prefills = { paths = vim.fn.expand("%") },
                })
            end, { desc = "grug-far: Search within range" })
            vim.keymap.set({ "n", "x" }, "<leader>gf", function()
                -- require("grug-far").open({ visualSelectionUsage = "operate-within-range" })
                require("grug-far").open({ transient = true })
            end, { desc = "grug-far: Search within range" })
        end,
    },
    {
        "smjonas/inc-rename.nvim",
        opts = {},
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
          { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
          { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
          { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
          { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
          { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },
    {
        "kylechui/nvim-surround",
        version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
        opts = {
            disable_filetype = { "TelescopePrompt", "vim" },
        },
    },
    {
        "rmagatti/goto-preview",
        dependencies = { "rmagatti/logger.nvim" },
        event = "BufEnter",
        config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
        keys = {
            {
                "<leader>ld",
                "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
                noremap = true,
                desc = "goto preview definition",
            },
            {
                "<leader>lD",
                "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
                noremap = true,
                desc = "goto preview declaration",
            },
            {
                "<leader>li",
                "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
                noremap = true,
                desc = "goto preview implementation",
            },
            {
                "<leader>ly",
                "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
                noremap = true,
                desc = "goto preview type definition",
            },
            {
                "<leader>lr",
                "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
                noremap = true,
                desc = "goto preview references",
            },
            {
                "<leader>L",
                "<cmd>lua require('goto-preview').close_all_win()<CR>",
                noremap = true,
                desc = "close all preview windows",
            },
        },
    },
    {
        "mbbill/undotree",
        cmd = { "UndotreeToggle", "UndotreeShow" },
        config = function()
            -- Optional: your custom Undotree settings here
            -- Example:
            -- vim.g.undotree_WindowLayout = 2
        end,
    },
}
