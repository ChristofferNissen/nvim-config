---@type vim.lsp.Config
return {
    cmd = { 'azure-pipelines-language-server', '--stdio' },
    filetypes = { 'yaml' },
    -- root_markers = { 'azure-pipelines.yml' },
    settings = {},
}
