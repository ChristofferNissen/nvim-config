return {
    "mason-org/mason.nvim",
    opts = {
        ensure_installed = {
            "yaml-language-server",
            "dockerfile-language-server",
            "docker-compose-language-service",
            "lua-language-server",
            -- c#
            "omnisharp",
            "csharp-language-server",
            "csharpier",
            "netcoredbg",
            "azure-pipelines-language-server",
            -- terraform
            "terraform-ls",
            "tflint",
            -- zig
            "zls",
            -- markdown
            "marksman",
            "markdownlint-cli2",
            "mermaid-cli",
            -- go
            "gopls",
            "gosimports",
            "gofumpt",
            "gomodifytags",
            "impl",
        }
    },
}
