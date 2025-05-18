---@type vim.lsp.Config
return {
    cmd = { 'azure-pipelines-language-server', '--stdio' },
    filetypes = { 'yaml', 'yml' },
    -- root_markers = { 'azure-pipelines.yml' },
    settings = {},
}
