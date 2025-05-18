local schemastore_schemas = require("schemastore").yaml.schemas {
    select = {
        'Azure Pipelines',
        'Argo Workflows',
        'Argo Events',
        'GitHub Action',
        'GitHub Workflow',
        'Taskfile config',
        'kustomization.yaml',
        'docker-compose.yml',
        'openapi.json',
        'gitlab-ci',
        'dependabot-v2.json',
        'Helm Chart.yaml',
        'Helm Chart.lock',
        'prettierrc.json',
    }
}

local custom_schemas = {
    kubernetes = "*.yaml",
}

local function merge_tables(t1, t2)
    local result = {}
    for k, v in pairs(t1) do result[k] = v end
    for k, v in pairs(t2) do result[k] = v end
    return result
end

local combined_schemas = merge_tables(schemastore_schemas, custom_schemas)

---@type vim.lsp.Config
return {
    cmd = { "yaml-language-server", "--stdio" },
    capabilities = {
        textDocument = {
            foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            },
        },
    },
    settings = {
        yaml = {
            keyOrdering = false,
            format = {
                enable = true,
            },
            validate = true,
            redhat = { telemetry = { enabled = false } },
            schemas = combined_schemas,
            schemaStore = {
                -- Must disable built-in schemaStore support to use
                -- schemas from SchemaStore.nvim plugin
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
            },
        },
    },
    single_file_support = true,
    filetypes = { "yml", "yaml", "yaml.docker-compose", "yaml.gitlab" },
}
