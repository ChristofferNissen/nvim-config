---@type vim.lsp.Config
return {
    cmd = { 'azure-pipelines-language-server', '--stdio' },
    filetypes = { 'yml' },
    root_markers = { 'azure-pipelines.yml' },
    settings = {},
}
