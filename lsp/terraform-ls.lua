---@type vim.lsp.Config
return {
    cmd = { "terraform-ls", "serve" },
    filetypes = { "terraform", "terraform-vars" },
    on_attach = function()
        require("treesitter-terraform-doc").setup({})
        -- Other on_attach configurations
    end,
}
