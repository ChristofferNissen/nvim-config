return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = function()
            require("lazy").load({ plugins = { "markdown-preview.nvim" } })
            vim.fn["mkdp#util#install"]()
        end,
        keys = {
            {
                "<leader>mp",
                ft = "markdown",
                "<cmd>MarkdownPreviewToggle<cr>",
                desc = "Markdown Preview",
            },
        },
        config = function()
            vim.cmd([[do FileType]])
        end,
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        -- opts = {},
        opts = {
            completions = { lsp = { enabled = true } },
            -- completions = { blink = { enabled = true } },
            code = {
                sign = false,
                width = "block",
                right_pad = 1,
            },
            heading = {
                sign = false,
                icons = {},
            },
            file_types = { "markdown", "norg", "rmd", "org", "Avante", "codecompanion" },
        },
        ft = { "markdown", "norg", "rmd", "org", "Avante", "codecompanion" },
        keys = {
            {
                "<leader>mr",
                ft = "markdown",
                "<cmd>RenderMarkdown toggle<cr>",
                desc = "Toggle Markdown preview",
            },
        },
    },
    -- {
    --     "OXY2DEV/markview.nvim",
    --     lazy = false,
    --     opts = {
    --         preview = {
    --             filetypes = { "markdown", "codecompanion" },
    --             ignore_buftypes = {},
    --         },
    --     },
    -- },
}
