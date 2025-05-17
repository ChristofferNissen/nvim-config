---@type vim.lsp.Config
return {
    cmd = { "yaml-language-server", "--stdio" },
    settings = {
        yaml = {
            format = {
                enable = true,
            },
            schemas = {
                kubernetes = "*.yaml",
                ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] =
                "/azure-pipeline*.y*l",
                ["https://taskfile.dev/schema.json"] = "**/Taskfile.yml",
                -- ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
                --     "/azure-pipeline*.y*l",
                --     "/*.azure*",
                --     "Azure-Pipelines/**/*.y*l",
                --     "Pipelines/*.y*l",
                -- },
                ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
                ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
                ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
                ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
                ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] =
                "*api*.{yml,yaml}",
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
                "*docker-compose*.{yml,yaml}",
                ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] =
                "*flow*.{yml,yaml}",
            },
            -- schemas = { kubernetes = '*.yaml' },
            -- validate = true,
            schemaStore = {
                -- Must disable built-in schemaStore support to use
                -- schemas from SchemaStore.nvim plugin
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
            },
            -- schemas = require("schemastore").yaml.schemas(),
        },
    },
    -- settings = {
    --     yaml = {
    --         schemas = {
    --             kubernetes = "k8s/**/*.{yaml}",
    --         },
    --         redhat = { telemetry = { enabled = false } },
    --     },
    -- },
    single_file_support = true,
    filetypes = { "yml", "yaml", "yaml.docker-compose", "yaml.gitlab" },
}
