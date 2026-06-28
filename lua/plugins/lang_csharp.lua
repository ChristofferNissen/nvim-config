return {
    {
        "GustavEikaas/easy-dotnet.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
        config = function()
            require("easy-dotnet").setup({
                projz_lsp = {
                    enabled = true,
                },
                lsp = {
                    enabled = true,
                    preload_roslyn = true,
                    roslynator_enabled = true,
                    easy_dotnet_analyzer_enabled = true,
                    aute_refresh_codelens = true,
                    analyzer_assemblies = {
                        "/home/cn/sonaranalyzers/SonarAnalyzer.CSharp.dll",
                    },
                },
                diagnostics = {
                    default_severity = "error", -- "error" or "warning" (default: "error")
                    setqflist = true,
                },
            })
        end,
        ft = { "cs", "csproj", "sln", "slnx", "props", "csx", "targets" },
    },
}
