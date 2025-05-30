return {
    {
        "mfussenegger/nvim-lint",
        config = function()
            require("lint").linters_by_ft = {
                python = { "flake8", "mypy" },
                lua = { "luacheck" },
                terraform = { "tflint", "tfsec", "terraform_validate" },
                markdown = { "markdownlint-cli2" },
                sh = { "shellcheck" },
                bash = { "shellcheck" },
                zsh = { "shellcheck" },
                go = { "golangci_lint" },
                yaml = { "yamllint" },
                dockerfile = { "hadolint" },
                helm = { "kube-linter" }, -- or helm_lint
                dotenv = { "dotenv-linter" },
            }
            -- Optionally set up an autocommand for linting on save
            -- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            vim.api.nvim_create_autocmd({ "BufReadPost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },
}
