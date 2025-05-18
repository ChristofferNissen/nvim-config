return {
    "mason-org/mason.nvim",
    -- keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    -- build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
        ensure_installed = {
            "yaml-language-server",
            "dockerfile-language-server",
            "docker-compose-language-service",
            "lua-language-server",
            "css-lsp",
            -- c#
            "omnisharp",
            -- "csharp-language-server",
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
            -- "mermaid-cli",
            -- bash
            "bash-language-server",
            "shellcheck",
            "shellharden",
            "shfmt",
            -- go
            "gopls",
            "goimports",
            "gofumpt",
            "gomodifytags",
            "impl",
        }
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
}
