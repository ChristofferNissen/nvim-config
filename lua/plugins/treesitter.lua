return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        main = "nvim-treesitter.configs",
        dependencies = {
            {
                "Afourcat/treesitter-terraform-doc.nvim",
                event = { "BufReadPost", "BufNewFile" },
                config = function()
                    require("treesitter-terraform-doc").setup({
                        command_name = "OpenDoc",
                        -- url_opener_command = "!firefox", -- "!w3m", -- or your preferred browser command
                        url_opener_command = "!xdg-open", -- or your preferred browser command
                        jump_argument = true,
                    })
                end,
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
            -- This is needed to ensure that the treesitter-terraform-doc works correctly
            vim.cmd([[command! -nargs=0 OpenDoc lua require('treesitter-terraform-doc').open_doc()]])
        end,
        opts = {
            autotag = {
                enable = true,
            },
            ensure_installed = {
                "html",
                "terraform",
                "hcl",
                "gleam",
                "nix",
                "zig",
                "go",
                "gomod",
                "gowork",
                "gosum",
                "gotmpl",
                "helm",
                "yaml",
                "c",
                "c_sharp",
                "dockerfile",
                "dot",
                "hyprlang",
                "markdown",
                "markdown_inline",
                "rust",
                "ron",
                "diff",
                "bash",
                "regex",
                "json5",
                "git_config",
                "gitcommit",
                "git_rebase",
                "gitignore",
                "gitattributes",
                "ninja",
                "rst",
                "kotlin",
                "java",
                "powershell",
                "latex",
            },
            highlight = {
                -- `false` will disable the whole extension
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
}
