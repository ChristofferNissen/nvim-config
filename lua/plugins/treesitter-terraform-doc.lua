return {
    "Afourcat/treesitter-terraform-doc.nvim",
    config = function()
        require("treesitter-terraform-doc").setup({
            command_name = "OpenDoc",
            url_opener_command = "!w3m", -- or your preferred browser command
            jump_argument = true,
        })
    end,
}
