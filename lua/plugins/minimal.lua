-- MINIMAL NVIM CONFIG
-- This file provides a minimal set of plugins for a lightweight editing experience.
-- To use this minimal configuration:
-- 1. Rename this file to replace the other plugin files, OR
-- 2. Modify lua/config/lazy.lua to import only this file
--
-- Plugins included:
-- - Treesitter: Syntax highlighting and code understanding
-- - Telescope: Fuzzy finder for files and text
-- - Tokyonight: Color scheme
-- - Mason: LSP/tool installer
-- - Blink.cmp: Auto-completion
-- - Gitsigns: Git integration
-- - Comment: Code commenting (gcc, gc in visual mode)
-- - nvim-autopairs: Auto-close brackets
-- - nvim-surround: Surround text with brackets/quotes
-- - mini.icons: Icons support
--
-- Total: 10 essential plugins (vs 50+ in full config)

return {
    -- ============================================
    -- SYNTAX & CODE UNDERSTANDING
    -- ============================================
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        main = "nvim-treesitter.configs",
        opts = {
            ensure_installed = {
                "lua",
                "vim",
                "vimdoc",
                "markdown",
                "markdown_inline",
                "bash",
                "json",
                "yaml",
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>",
                    node_incremental = "<CR>",
                    scope_incremental = "<S-CR>",
                    node_decremental = "<BS>",
                },
            },
        },
    },

    -- ============================================
    -- FUZZY FINDER
    -- ============================================
    {
        "nvim-telescope/telescope.nvim",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        keys = {
            {
                "<leader>pf",
                function()
                    require("telescope.builtin").find_files()
                end,
                desc = "Find files",
            },
            {
                "<C-p>",
                function()
                    require("telescope.builtin").git_files()
                end,
                desc = "Git files",
            },
            {
                "<leader>ps",
                function()
                    require("telescope.builtin").live_grep()
                end,
                desc = "Live grep",
            },
            {
                "<leader>pb",
                function()
                    require("telescope.builtin").buffers()
                end,
                desc = "Buffers",
            },
            {
                "<leader>pr",
                function()
                    require("telescope.builtin").resume()
                end,
                desc = "Resume",
            },
        },
        config = function()
            require("telescope").setup({})
            require("telescope").load_extension("fzf")
        end,
    },

    -- ============================================
    -- COLOR SCHEME
    -- ============================================
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({ style = "storm" })
            vim.cmd([[colorscheme tokyonight-storm]])
        end,
    },

    -- ============================================
    -- LSP & TOOLS INSTALLER
    -- ============================================
    {
        "mason-org/mason.nvim",
        event = "VeryLazy",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "stylua",
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            mr.refresh(function()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end)
        end,
    },

    -- ============================================
    -- AUTO-COMPLETION
    -- ============================================
    {
        "saghen/blink.cmp",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
                dependencies = { "rafamadriz/friendly-snippets" },
            },
        },
        version = "1.*",
        opts = {
            keymap = { preset = "default" },
            appearance = { nerd_font_variant = "mono" },
            completion = { documentation = { auto_show = false } },
            snippets = { preset = "luasnip" },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            signature = { enabled = true },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
    },

    -- ============================================
    -- GIT INTEGRATION
    -- ============================================
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost" },
        opts = {},
    },

    -- ============================================
    -- EDITING ENHANCEMENTS
    -- ============================================
    {
        "numToStr/Comment.nvim",
        opts = {},
        event = { "BufReadPost", "BufNewFile" },
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    {
        "kylechui/nvim-surround",
        version = "^3.0.0",
        event = "VeryLazy",
        opts = {},
    },

    -- ============================================
    -- ICONS (required by other plugins)
    -- ============================================
    {
        "echasnovski/mini.icons",
        opts = {},
        lazy = true,
    },
}
