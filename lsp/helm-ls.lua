---@type vim.lsp.Config
return {
    cmd = { "helm_ls", "serve" }, -- adjust if your binary has a different name/location
    filetypes = { "helm" },       -- or {"yaml"} if you want it on all YAML, but "helm" is recommended
    root_markers = { "Chart.yaml", ".git" },
    settings = {},                -- add custom settings here if needed
}
