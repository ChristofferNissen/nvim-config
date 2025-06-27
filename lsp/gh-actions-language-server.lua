---@type vim.lsp.Config
return {
    -- Optional: specify the command if not in PATH
    cmd = { "gh-actions-language-server", "--stdio" },
    -- Optional: custom filetypes
    filetypes = { "github-actions" },
    -- Optional: root directory logic
    root_markers = { ".github/workflows", ".git" },
    -- Optional: any custom settings
    settings = {
        -- Add your custom settings here
    },
    -- Optional: on_attach and capabilities for completion, etc.
    -- on_attach = function(client, bufnr)
    --   -- keymaps, etc.
    -- end,
    -- capabilities = capabilities,
}
