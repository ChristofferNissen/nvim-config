---@type vim.lsp.Config
return {
    cmd = { "kotlin-lsp", "--stdio" },
    single_file_support = true,
    filetypes = { "kotlin" },
    -- root_markers = { "build.gradle", "build.gradle.kts", "pom.xml" },
    root_markers = {
        "settings.gradle", -- Gradle (multi-project)
        "settings.gradle.kts", -- Gradle (multi-project)
        "pom.xml", -- Maven
        "build.gradle", -- Gradle
        "build.gradle.kts", -- Gradle
        "workspace.json", -- Used to integrate your own build system
    },
    settings = {},
}
