---@type vim.lsp.Config
return {
    cmd = { 'OmniSharp', '-lsp' },
    filetypes = { 'sln', "cs" },
    -- root_markers = { 'azure-pipelines.yml' },
    settings = {},
}
