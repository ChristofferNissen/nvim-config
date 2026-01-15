return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                -- Customize or remove this keymap to your liking
                "<leader>cf",
                function()
                    require("conform").format({ async = true })
                    vim.notify("Formatted buffer", vim.log.levels.INFO)
                end,
                mode = "",
                desc = "Format buffer",
            },
        },
        -- This will provide type hinting with LuaLS
        ---@module "conform"
        ---@type conform.setupOpts
        opts = {
            -- Define your formatters
            formatters_by_ft = {
                -- Python
                python = { "black" },
                -- Shell (sh, bash, zsh)
                sh = { "shfmt", "shellharden" },
                bash = { "shfmt", "shellharden" },
                zsh = { "shfmt", "shellharden" },
                -- Go
                go = { "gofumpt", "goimports", "golangci-lint" },
                -- C, C++, Objective-C
                -- c = { "clang-format" },
                cpp = { "clang-format" },
                objc = { "clang-format" },
                -- C#
                cs = { "csharpier" },
                -- JSON
                json = { "jq" },
                -- Markdown
                markdown = { "markdownlint-cli2" },
                -- Nix
                nix = { "nixfmt", "nixpkgs_fmt" },
                -- Lua
                lua = { "stylua" },
                -- Terraform
                terraform = { "terraform_fmt" },
                -- YAML
                -- yaml = { "yamlfmt", "yamlfix" },
                -- Zig
                zig = { "zigfmt" },
                sql = { "sqruff" },
            },
            -- Set default options
            default_format_opts = {
                lsp_format = "fallback",
            },
            -- Set up format-on-save
            -- format_on_save = { timeout_ms = 500 },
            -- format_after_save = { async = true },

            -- Customize formatters
            formatters = {
                shfmt = {
                    prepend_args = { "-i", "2" },
                },
                csharpier = {
                    command = "dotnet-csharpier",
                    args = { "--write-stdout" },
                },
            },
        },
        init = function()
            -- If you want the formatexpr, here is the place to set it
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },
}
