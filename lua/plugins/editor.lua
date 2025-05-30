return {
    {
        "b0o/SchemaStore.nvim",
        lazy = true,
        version = false, -- last release is way too old
    },
    {
        "towolf/vim-helm",
        ft = "helm",
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
        event = { "BufReadPost", "BufNewFile" },
    },
    {
        "nat-418/boole.nvim",
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
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        opts = {
            modes = { insert = true, command = true, terminal = false },
            -- skip autopair when next character is one of these
            skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
            -- skip autopair when the cursor is inside these treesitter nodes
            skip_ts = { "string" },
            -- skip autopair when next character is closing pair
            -- and there are more closing pairs than opening pairs
            skip_unbalanced = true,
            -- better deal with markdown code blocks
            markdown = true,
        },
        version = false,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        optional = true,
        event = "LazyFile",
        opts = {
            scope = { enabled = false },
        },
    },
    {
        "gbprod/substitute.nvim",
        -- stylua: ignore
        keys = {
            { "<leader>r",  mode = "n", function() require('substitute').operator() end, desc = "substitute w/ motion" },
            { "<leader>rr", mode = "n", function() require('substitute').line() end,     desc = "substitute w/ line" },
            { "<leader>R",  mode = "n", function() require('substitute').eol() end,      desc = "substitute w/ eol" },
            { "<leader>r",  mode = "x", function() require('substitute').visual() end,   desc = "substitute w/ visual" },
        },
        opts = {},
    },
    {
        "mfussenegger/nvim-lint",
        config = function()
            require("lint").linters_by_ft = {
                python = { "flake8", "mypy" },
                lua = { "luacheck" },
                -- add more filetypes and linters as needed
                terraform = { "tflint", "tfsec", "terraform_validate" },
                markdown = { "markdownlint-cli2" },
                sh = { "shellcheck", "shfmt", "shellharden", "beautysh" },
                bash = { "shellcheck", "shfmt", "shellharden", "beautysh" },
                go = { "golangci_lint" },
                yaml = { "yamllint", "yamlfix" },
                dockerfile = { "hadolint" },
                helm = { "kube-linter" }, -- or helm_lint
                dotenv = { "dotenv-linter" },
            }
            -- Optionally set up an autocommand for linting on save
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                -- Customize or remove this keymap to your liking
                "<leader>f",
                function()
                    require("conform").format({ async = true })
                end,
                mode = "",
                desc = "Format buffer",
            },
        },
        -- This will provide type hinting with LuaLS
        ---@module "conform"
        ---@type conform.setupOpts
        opts = {
            -- Define your formatters
            formatters_by_ft = {
                -- Python
                python = { "black" },

                -- Shell (sh, bash, zsh)
                sh = { "shfmt", "shellharden", "beautysh" },
                bash = { "shfmt", "shellharden", "beautysh" },
                zsh = { "shfmt", "shellharden", "beautysh" },

                -- Go
                go = { "gofumpt", "goimports", "golangci-lint" },

                -- C, C++, Objective-C
                c = { "clang-format" },
                cpp = { "clang-format" },
                objc = { "clang-format" },

                -- C#
                cs = { "csharpier" },

                -- JSON
                json = { "jq" },

                -- Markdown
                markdown = { "markdownlint-cli2" },

                -- Nix
                nix = { "nixfmt", "nixpkgs_fmt" },

                -- Lua
                lua = { "stylua" },

                -- Terraform
                terraform = { "terraform_fmt" },

                -- YAML
                yaml = { "yamlfmt", "yamlfix" },

                -- Zig
                zig = { "zigfmt" },
            },
            -- Set default options
            default_format_opts = {
                lsp_format = "fallback",
            },
            -- Set up format-on-save
            format_on_save = { timeout_ms = 500 },
            -- Customize formatters
            formatters = {
                shfmt = {
                    prepend_args = { "-i", "2" },
                },
            },
        },
        init = function()
            -- If you want the formatexpr, here is the place to set it
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },
}
