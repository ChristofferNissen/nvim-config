---@type vim.lsp.Config
return {
    cmd = { "snyk-ls" },
    -- filetypes = { "javascript", "typescript", "python", "go", "java", "ruby", "php", "csharp" }, -- Extend as needed
    -- root_dir = lspconfig.util.root_pattern("package.json", ".git", "requirements.txt", "go.mod", "pom.xml", "Gemfile"),
    single_file_support = true,
    settings = {},
    init_options = {
        automaticAuthentication = "false",
    },
}
