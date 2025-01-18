return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    main = "nvim-treesitter.configs",
    dev = true,
    opts = {
        autotag = {
            enable = true,
        },
        ensure_installed = {
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
}
