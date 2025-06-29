return {
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
}
