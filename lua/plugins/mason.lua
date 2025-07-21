return {
    {
        "mason-org/mason.nvim",
        -- keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        -- build = ":MasonUpdate",
        event = "VeryLazy",
        opts_extend = { "ensure_installed" },
        opts = {
            registries = {
                "github:mason-org/mason-registry",
                "github:Crashdummyy/mason-registry",
            },
            ensure_installed = {
                "css-lsp",
                "harper-ls",
                "ast-grep",
                -- python
                "black",
                -- yaml
                "gh",
                "gh-actions-language-server",
                "yaml-language-server",
                "yamlfix",
                "yamlfmt",
                "yamllint",
                "yq",
                -- json
                "jq",
                "jq-lsp",
                "json-lsp",
                -- docker
                "dockerfile-language-server",
                "docker-compose-language-service",
                "hadolint",
                "trivy",
                -- lua
                "lua-language-server",
                "luacheck",
                "stylua",
                -- kubernetes
                "kube-linter",
                "helm-ls",
                -- nix
                "nixfmt",
                "nixpkgs-fmt",
                "nil",
                -- c#
                "clang-format",
                "roslyn",
                "rzls",
                -- "omnisharp",
                -- "csharp-language-server",
                "csharpier",
                "netcoredbg",
                "azure-pipelines-language-server",
                -- terraform
                "terraform",
                "terraform-ls",
                "tflint",
                -- "tfsec", -- part of trivy now
                -- zig
                "zls",
                -- markdown
                "marksman",
                "markdownlint-cli2",
                "mdx-analyzer",
                -- "mermaid-cli",
                "powershell-editor-services",
                -- bash
                "bash-debug-adapter",
                "bash-language-server",
                "beautysh",
                "shellcheck",
                "shellharden",
                "shfmt",
                "dotenv-linter",
                "gitui",
                -- go
                "gopls",
                "goimports",
                "gofumpt",
                "gomodifytags",
                "impl",
                "golangci-lint",
                "templ",
                -- rust
                "rust-analyzer",
                -- typescript
                "typescript-language-server",
                -- java
                "jdtls",
                "java-debug-adapter",
                "java-test",
                "ktlint",
                -- kotlin
                "kotlin-lsp",
                "ktfmt",
                -- SQL
                "sqlls",
                "sqruff",
                -- "postgresstools"
            },
        },
        ---@param opts MasonSettings | {ensure_installed: string[]}
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            mr:on("package:install:success", function()
                vim.defer_fn(function()
                    -- trigger FileType event to possibly load this newly installed LSP server
                    require("lazy.core.handler.event").trigger({
                        event = "FileType",
                        buf = vim.api.nvim_get_current_buf(),
                    })
                end, 100)
            end)

            mr.refresh(function()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end)
        end,
    },
}
