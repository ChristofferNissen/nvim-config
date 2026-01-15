return {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
        require("easy-dotnet").setup({
            lsp = {
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
    opts = {},
}
