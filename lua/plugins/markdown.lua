return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                marksman = {},
            },
        },
    },
    -- Markdown preview
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        ft = "markdown",
        keys = {
            { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
        },
        config = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
    },
    {
        "jghauser/papis.nvim",
        ft = "markdown",
        dependencies = { "nvim-telescope/telescope.nvim" },
        keys = {
            { "<leader>ip", "<cmd>Papis<cr>", desc = "Insert Papis" },
        },
        config = function(_, opts)
            require("papis").setup(opts)
        end,
    },
    {
        "lukas-reineke/headlines.nvim",
        ft = { "markdown" },
        config = true,
    },
    {
        "dhruvasagar/vim-table-mode",
        ft = { "markdown" },
        keys = {
            { "<leader>tm", "<cmd>TableModeToggle<cr>", desc = "Toggle Table Mode" },
        },
    },
}
