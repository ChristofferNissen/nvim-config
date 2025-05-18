---@type vim.lsp.Config
return {
    cmd = { "helm_ls", "serve" }, -- adjust if your binary has a different name/location
    filetypes = { 'helm' },       -- or {"yaml"} if you want it on all YAML, but "helm" is recommended
    -- root_dir = lspconfig.util.root_pattern("Chart.yaml", ".git"),
    -- root_markers = { 'Chart.yaml' },
    settings = {}, -- add custom settings here if needed
}
