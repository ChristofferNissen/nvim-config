return {
    {
        "mfussenegger/nvim-lint",
        event = { "BufWritePre" },
        config = function()
            local locator = require("kube_linter_yaml_locator")

            require("lint").linters.kube_linter = {
                name = "kube_linter",
                cmd = "kube-linter",
                stdin = false,
                args = {
                    "lint",
                    function()
                        return vim.api.nvim_buf_get_name(0)
                    end,
                },
                stream = "stdout",
                ignore_exitcode = true,
                parser = function(output, bufnr, cwd)
                    if output == "" then
                        return {}
                    end
                    local diagnostics = {}
                    -- local current_file = vim.api.nvim_buf_get_name(bufnr)

                    for line in output:gmatch("[^\r\n]+") do
                        if line:match("^KubeLinter") or line:match("^Error:") or line:match("^%s*$") then
                            goto continue
                        end
                        -- Example line:
                        -- /path/to/file.yaml: (object: <no namespace>/my-dep apps/v1, Kind=Deployment) The container "busybox" is using an invalid container image... (check: latest-tag, remediation: ...)
                        local filepath, objinfo, main_message, check_name, remediation =
                            line:match("^([^:]+): %(object: ([^)]+)%) (.+) %(check: ([^,]+), remediation: (.+)%)$")
                        if filepath and objinfo and main_message and check_name and remediation then
                            local kind = objinfo:match("Kind=(%w+)")
                            local name = objinfo:match("/([^%s]+) ")
                            local lnum = 0
                            if kind and name then
                                lnum = locator.find_object_line(bufnr, kind, name)
                            end
                            local full_message = main_message .. "\nRemediation: " .. remediation
                            table.insert(diagnostics, {
                                lnum = lnum,
                                col = 0,
                                end_lnum = lnum,
                                end_col = 100,
                                message = full_message,
                                code = check_name,
                                severity = vim.diagnostic.severity.WARN,
                                source = "kube-linter",
                            })
                        end
                        ::continue::
                    end
                    return diagnostics
                end,
            }
            require("lint").linters_by_ft = {
                python = { "flake8", "mypy" },
                lua = { "luacheck" },
                terraform = { "tflint", "tfsec", "terraform_validate" },
                markdown = { "markdownlint-cli2" },
                sh = { "shellcheck" },
                bash = { "shellcheck" },
                zsh = { "shellcheck" },
                go = { "golangci_lint" },
                yaml = { "yamllint", "kube_linter" },
                dockerfile = { "hadolint" },
                helm = { "kube_linter" }, -- or helm_lint
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
